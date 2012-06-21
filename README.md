PrettyComment
=============

Ruby gem to pretty-print status messages and comments to the terminal. The text is formatted to fill the full width
of the terminal.


Usage:
------

### Headers:
```
puts PrettyComment.h1("To be or not to be")
puts
puts PrettyComment.h2("That is the question")
puts
puts PrettyComment.h3("Whether 'tis nobler in the mind")
```

will result in:

```
################################################################################
# To be or not to be                                                           #
################################################################################

#==============================================================================#
# That is the question                                                         #
#==============================================================================#

#------------------------------------------------------------------------------#
# Whether 'tis nobler in the mind                                              #
#------------------------------------------------------------------------------#
```

### Text Formatting:

```
Prefix = "Summary:"
PrefixOnlyFirstLine = true
puts PrettyComment.format_line(Summary, Prefix, PrefixOnlyFirstLine)
```

will result in:

```
Summary: The play is set in Denmark at the Castle Elsinore. The King Hamlet     
         has just died and his brother, Claudius, has replaced him and also     
         married his dead brother's wife, Gertrude. In the second scene of ACT  
         I, Claudius addresses the court on his recent marriage to Gertrude,    
         on political matters and also gives his blessings to Laertes, the son  
         of the Lord Chamberlain Polonius, who is about to leave for France.    
         He then turns to Hamlet, who is still mourning his father and doesn't  
         seem to get over it. Even if it's natural to mourn his father's        
         death, he argues, he should get over it.  
```

### Separators:
```
puts PrettyComment.separator
puts PrettyComment.small_separator
puts PrettyComment.separator '*'
```

```
#==============================================================================#
#------------------------------------------------------------------------------#
#******************************************************************************#
```

### Boxes:
``` 
a_box = PrettyComment::Box.new do
  para "Summary:"
  hline '-'
  para "The play is set in Denmark at the Castle Elsinore. The King Hamlet has just died and his brother, Claudius, has replaced him and also married his dead brother's wife, Gertrude. In the second scene of ACT I, Claudius addresses the court on his recent marriage to Gertrude, on political matters and also gives his blessings to Laertes, the son of the Lord Chamberlain Polonius, who is about to leave for France. He then turns to Hamlet, who is still mourning his father and doesn't seem to get over it. Even if it's natural to mourn his father's death, he argues, he should get over it."
  h3   "Dramatis Personae:"
  para "Hamlet: Son of the former king, and nephew of the present King\n"
  para "Claudius: King of Denmark, Hamlet's uncle.\n"
  para "Gertrude: Queen of Denmark, and mother to Hamlet\n"
  para "Polonius: Lord Chamberlain\n"
  para "Ophelia: Daughter to Polonius\n"
  para "Horatio: Friend to Hamlet\n"
  para "Laertes: Son to Polonius\n"
  para "Voltimand, Cornelius: Courtiers\n"
  para "Rosencrantz, Guildenstern: Courtiers, friends to Hamlet\n"
  para "Osric: a Courtier\n"
  para "Marcellus: an Officer\n"
  para "Bernardo: an Officer\n"
  para "Francisco: a Soldier\n"
  para "Reynaldo: Servant to Polonius\n"
  para "Ghost of Hamlet's Father\n"
  para "Fortinbras: Prince of Norway\n"
  para "Gravediggers: A sexton and a clown\n"
  para "Player King, Player Queen, Lucianus, etc.: Players\n"
end  
```

will result in:
```
#==============================================================================#
# Summary:                                                                     #
#------------------------------------------------------------------------------#
# The play is set in Denmark at the Castle Elsinore. The King Hamlet has just  #
# died and his brother, Claudius, has replaced him and also married his dead   #
# brother's wife, Gertrude. In the second scene of ACT I, Claudius addresses   #
# the court on his recent marriage to Gertrude, on political matters and also  #
# gives his blessings to Laertes, the son of the Lord Chamberlain Polonius,    #
# who is about to leave for France. He then turns to Hamlet, who is still      #
# mourning his father and doesn't seem to get over it. Even if it's natural    #
# to mourn his father's death, he argues, he should get over it.               #
#------------------------------------------------------------------------------#
# Dramatis Personae:                                                           #
#------------------------------------------------------------------------------#
# Hamlet: Son of the former king, and nephew of the present King               #
# Claudius: King of Denmark, Hamlet's uncle.                                   #
# Gertrude: Queen of Denmark, and mother to Hamlet                             #
# Polonius: Lord Chamberlain                                                   #
# Ophelia: Daughter to Polonius                                                #
# Horatio: Friend to Hamlet                                                    #
# Laertes: Son to Polonius                                                     #
# Voltimand, Cornelius: Courtiers                                              #
# Rosencrantz, Guildenstern: Courtiers, friends to Hamlet                      #
# Osric: a Courtier                                                            #
# Marcellus: an Officer                                                        #
# Bernardo: an Officer                                                         #
# Francisco: a Soldier                                                         #
# Reynaldo: Servant to Polonius                                                #
# Ghost of Hamlet's Father                                                     #
# Fortinbras: Prince of Norway                                                 #
# Gravediggers: A sexton and a clown                                           #
# Player King, Player Queen, Lucianus, etc.: Players                           #
#==============================================================================#
```

###Styles:

```
puts PrettyComment::Box.new {
  box_style  'c++'
  box_width  120
  para "This is a long c++ source comment box."
}
puts

puts PrettyComment::Box.new {
  box_style  'latex'
  para "This is a latex comment box."
}
puts

puts PrettyComment::Box.new {
  box_left '|'
  box_right '/'
  box_top '*'
  box_bottom '#'
  para "This is a custom box."
}
```

will result in:


```
//====================================================================================================================//
// This is a long c++ source comment box.                                                                             //
//====================================================================================================================//

%==============================================================================%
% This is a latex comment box.                                                 %
%==============================================================================%

|******************************************************************************/
| This is a custom box.                                                        /
|##############################################################################/
```


Currently the following styles are implemented:
 * default for terminal, ruby, python etc.
 * c++
 * latex
 
Styles can also be set globally on the Box class:

```
PrettyComment::Box::style = 'c++'
PrettyComment::Box::width = 120
PrettyComment::Box::left = '#'
etc.
```
