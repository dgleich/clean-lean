# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""UI checks for an explicitly incomplete progressive snapshot; requires Playwright."""
import argparse,json
from pathlib import Path
from playwright.sync_api import sync_playwright,expect
root=Path(__file__).resolve().parents[1]
parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--snapshot',type=Path,default=root/'docs/review.html')
args=parser.parse_args()
with sync_playwright() as p:
 browser=p.chromium.launch()
 page=browser.new_page(viewport={'width':1440,'height':1000});errors=[]
 page.on('pageerror',lambda e:errors.append(str(e)))
 page.goto(args.snapshot.resolve().as_uri())
 data=json.loads(page.locator('#review-data').text_content())
 assert data['complete'] is False
 pending=sum(f['status']=='Translation pending' for f in data['files'])
 expect(page.locator('#build-state')).to_contain_text(str(pending)+' translations pending')
 assert page.locator('#files button').count()==len(data['files'])
 target='studies/universe-classifiers/CarrierRecords.clean'
 page.locator('#search').fill(target)
 page.locator('#files button',has_text=target).click()
 expect(page.locator('#path')).to_have_text(target)
 file=next(f for f in data['files'] if f['path']==target)
 shown=page.locator('#source .line').evaluate_all('(rows)=>rows.map(r=>r.lastElementChild.textContent).join("\\n")')
 assert shown==file['source'],(len(shown),len(file['source']))
 expect(page.locator('#status')).to_have_text('Translation pending')
 page.locator('#note').fill('Review dependent carrier fields.')
 page.reload();expect(page.locator('#note')).to_have_value('Review dependent carrier fields.')
 # Drafts are reviewable even when their imported interfaces do not exist yet.
 target='studies/laproof/Paper.clean.proposed'
 page.locator('#search').fill(target)
 page.locator('#files button',has_text=target).click()
 expect(page.locator('#path')).to_have_text(target)
 expect(page.locator('#status')).to_have_text('Proposed syntax · no translation attempted')
 expect(page.locator('#error')).to_be_hidden()
 expect(page.locator('#lean')).to_contain_text('No translation available.')
 expect(page.locator('#imports')).to_contain_text('IEEE754.clean (not in snapshot)')
 assert page.locator('#imports a',has_text='IEEE754.clean').count()==0
 page.locator('#imports a',has_text='Bounds.clean').click()
 expect(page.locator('#path')).to_have_text('studies/laproof/Bounds.clean')
 target='studies/topology/Targets.clean.proposed'
 page.locator('#search').fill(target)
 page.locator('#files button',has_text=target).click()
 expect(page.locator('#status')).to_have_text('Proposed syntax · no translation attempted')
 page.locator('#outline button',has_text='increasing death critical set').click()
 expect(page.locator('#source .selected')).to_contain_text('Result increasing death critical set:')
 page.screenshot(path='/tmp/clean-progressive-review-desktop.png',full_page=True)
 page.set_viewport_size({'width':390,'height':844})
 assert page.evaluate('document.documentElement.scrollWidth <= window.innerWidth')
 page.screenshot(path='/tmp/clean-progressive-review-mobile.png',full_page=True)
 assert not errors,errors
 browser.close()
 print('Progressive UI passed:',len(data['files']),'sources;',pending,'pending; source fidelity, search, navigation, notes and mobile layout.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
