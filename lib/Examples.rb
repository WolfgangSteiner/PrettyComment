# encoding: utf-8
require "./lib/PrettyComment"

Summary = <<-EOL
The play is set in Denmark at the Castle Elsinore. The King Hamlet has just died and his brother, Claudius, has replaced him and also married his dead brother's wife, Gertrude. In the second scene of ACT I, Claudius addresses the court on his recent marriage to Gertrude, on political matters and also gives his blessings to Laertes, the son of the Lord Chamberlain Polonius, who is about to leave for France. He then turns to Hamlet, who is still mourning his father and doesn't seem to get over it. Even if it's natural to mourn his father's death, he argues, he should get over it.
EOL

puts PrettyComment.h1("To be or not to be")
puts
puts PrettyComment.h2("That is the question")
puts
puts PrettyComment.h3("Whether 'tis nobler in the mind")
puts

Prefix = "Summary:"
PrefixOnlyFirstLine = true
puts PrettyComment.format_line(Summary, Prefix, PrefixOnlyFirstLine)
puts

puts PrettyComment.separator
puts PrettyComment.small_separator
puts PrettyComment.separator '*'
puts

a_box = PrettyComment::Box.new do
  para "Summary:"
  hline '-'
  para Summary
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

puts a_box
puts 

puts PrettyComment::Box.new {
  box_style  'c++'
  box_width  120
  para "This is a c++ source comment box."
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
  para "This is a free-form box."
}

