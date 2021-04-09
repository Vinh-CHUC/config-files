## Submodule cheatsheet

### Cloning from a repo with submodules
```
git clone ..
git submodule init  # Initialises git configuration from .gitmodules
git submodule update  # Will checkout the submodule
```

or equivalently
```
git clone
git submodule update --init
```

or equivalently
```
git clone --recursive ...
```

### Adding commits to the submodules

#### Maintainer of the 'container' repo

##### Modifying a submodule

1. Go to the submodule and issue various commands e.g.:
```
cd path/to/the/submodule
git checkout xxx
```
or one wants to automatically refresh all submodules to their latest master:
```
git submodule update --remote
```
2. Check the status:
```
git diff
```
or
```
git diff --submodule=log
```
3. Commut & Push
```
git commit -am 'xxx'
git push
```

##### Adding a submodule
```git submodule add```

#### Other people that use the container repo
```
git pull  # This fetches the submodule updates but does NOT update!!!
git submodule update  # Mandatory
```
Better, safer:
```
git pull
git submodule update --init --recursive  # To ensure one catches new submodules for example
```
Potentially a `git submodule sync` if the url has changed

Basically the best and safest is:
```
git pull
git submodule sync --recursive
git submodule update --init -recursive
```
