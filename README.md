# FameStastistics

Computing some statistics on Fame traits usage:
- How many traits exist
- How many in each category (associations, technical, property, source-entity)
- How many used in the different Famix meta-model

To count the number of traits:
```St
TraitsCounting allTraits.

TraitsCounting associationsTraits.
TraitsCounting technicalTraits.
TraitsCounting propertyTraits.
TraitsCounting sourceEntityTraits.
```

To count the traits in a Famix meta-model:
```St
TraitsCounting metamodelReport: FamixJavaModel
```
