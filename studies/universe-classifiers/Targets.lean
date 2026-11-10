-- generated: gpt-6 2026-11-10 role=assisted; proposed mapping, not generated Clean
import Lean

namespace UniverseClassifierProposal
abbrev SmallTypes : Type 1 := Type
abbrev LargeTypes : Type 2 := Type 1

structure SpaceObject : Type 1 where
 carrier : Type

-- Generic declaration binders use the primitive sort specified by Classifies.
def equalLarge {A : Type 1} (x y : A) : Prop := x = y
def equalHigher {A : Type 2} (x y : A) : Prop := x = y

-- Ordinary statement binders retain their declared classifier wrapper.
def typeReflexivity : Prop := ∀ (A : LargeTypes), equalHigher A A
-- Equality of bundled objects is different from equality of their carrier types.
def objectReflexivity : Prop := ∀ (X : SpaceObject), equalLarge X X

theorem typeReflexivityChecked : typeReflexivity := by intro A; rfl
theorem objectReflexivityChecked : objectReflexivity := by intro X; rfl

-- A first-class type value has an explicit classifier, not an inferred name.
def spaceTypeValue : LargeTypes := SpaceObject

structure LargePackage : Type 2 where
 carrier : LargeTypes
 element : carrier

-- Local carrier fields preserve their level in dependent fields.
def packageReflexivity : Prop := ∀ (P : LargePackage), equalLarge P.element P.element
theorem packageReflexivityChecked : packageReflexivity := by intro P; rfl
end UniverseClassifierProposal

-- generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
