"""Optional browser integration checks; requires Playwright + Chromium."""
import json
from pathlib import Path
from playwright.sync_api import sync_playwright, expect
ROOT=Path(__file__).resolve().parents[1]
with sync_playwright() as p:
    browser=p.chromium.launch()
    page=browser.new_page(viewport={'width':1440,'height':1000})
    errors=[]; page.on('pageerror',lambda e:errors.append(str(e)))
    page.goto((ROOT/'docs/review.html').as_uri())
    expect(page.locator('#path')).to_have_text('library/analysis.clean')
    assert page.locator('#files button').count()==len(json.loads(page.locator('#review-data').text_content())['files'])
    assert page.locator('#source .keyword').count()>0
    page.locator('#search').fill('commutator')
    assert page.locator('#files button').count()==2
    page.locator('#files button',has_text='library/linear_algebra.clean').click()
    expect(page.locator('#path')).to_have_text('library/linear_algebra.clean')
    page.locator('#outline button',has_text='define commutator').click()
    expect(page.locator('#source .selected')).to_contain_text('Define commutator')
    assert page.locator('#lean').evaluate('(e)=>e.scrollTop')>0
    page.locator('#note').fill('Line 29: review the commutator rendering.')
    page.reload()
    expect(page.locator('#note')).to_have_value('Line 29: review the commutator rendering.')
    with page.expect_download() as download:
        page.locator('#export').click()
    content=json.loads(Path(download.value.path()).read_text())
    assert content['notes'][0]['path']=='library/linear_algebra.clean'
    assert len(content['notes'][0]['sourceSHA256'])==64
    page.evaluate("const notes=JSON.parse(localStorage.getItem('clean-review-notes-v1'));notes['library/linear_algebra.clean'].sourceSHA256='earlier';localStorage.setItem('clean-review-notes-v1',JSON.stringify(notes));")
    page.reload()
    expect(page.locator('#saved')).to_contain_text('earlier source snapshot')
    page.locator('#imports a',has_text='types.clean').click()
    expect(page.locator('#path')).to_have_text('library/types.clean')
    page.locator('#search').fill('not-found-unique')
    expect(page.locator('#empty')).to_be_visible()
    page.locator('#search').fill('')
    page.locator('#group').select_option('corpus')
    assert page.locator('#files button').count()==4
    page.locator('#files button',has_text='corpus/analysis.clean').click()
    page.locator('#show-lean').uncheck()
    expect(page.locator('#lean-pane')).to_be_hidden()
    page.locator('#wrap').check()
    page.screenshot(path='/tmp/clean-review-desktop.png',full_page=True)
    page.set_viewport_size({'width':390,'height':844})
    assert page.evaluate('document.documentElement.scrollWidth <= window.innerWidth')
    page.screenshot(path='/tmp/clean-review-mobile.png',full_page=True)
    # Escaping regression: literal markup is inert even in an authored comment.
    assert page.locator('#review-data').count()==1
    nojs=browser.new_context(java_script_enabled=False).new_page()
    nojs.goto((ROOT/'docs/review.html').as_uri())
    expect(nojs.locator('noscript')).to_be_visible()
    assert not errors,errors
    browser.close()
print('Review browser: search, declarations, target navigation, imports, notes/export, reload, responsive layout and no-JS fallback passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
