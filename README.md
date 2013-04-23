#mruby-Avl#

A sensible Avl Tree implementation for mruby. - which means you should
be sensible when you use it!

# Fast Food #

1. First - get your self some mruby. It tastes great!

```
git clone git https://github.com/mruby/mruby.git
```

1.2. Read the recipie and start your preparations.

```
cd mruby
less INSTALL
ruby minirake all test
```

1.3. Have a taste!

```
./bin/mruby -e 'p "Hello mruby!!"'
```

(For the sake of convenience, you might want to add mruby/bin to your path) 

2. Grab some greens

```
cd ..
git clone git https://github.com/randym/mruby-avl
```

2.1 Add the greens to your dish.

```
vim mruby/build_config.rb

...

# Use AvlTree class
conf.gem "~/mruby-avl"
```

(Note, I used ~ there because I cloned mruby-avl to my home directory so be sure to season to taste.) 

3. Finish the presentation.

```
cd mruby
ruby minirake clean all test
```

4. Enjoy your meal!

```
mirb
tree = AvlTree.new
tree.insert 'F', 1
tree.insert 'boo', :foo
tree['boo'] => :foo
tree.delete 'F'
# I think you get the flavor!
```


