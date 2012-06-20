# encoding: utf-8
#======================================================================================================================#
require 'terminfo'

#======================================================================================================================#

module PrettyComment


#======================================================================================================================#

def self.terminal_width
  TermInfo.screen_size[1]
end


#----------------------------------------------------------------------------------------------------------------------#

def self.separator(char='=')
  '#' + (char * (terminal_width - 2)) + '#'
end  


#----------------------------------------------------------------------------------------------------------------------#

def self.small_separator
  separator ('-')
end  


#----------------------------------------------------------------------------------------------------------------------#

def self.comment(comment)
  pad_string("\# #{comment}", "#", terminal_width)
end


#----------------------------------------------------------------------------------------------------------------------#

def self.sub_heading(comment)
  [comment(""), small_separator, comment(comment), small_separator].join("\n")
end


#----------------------------------------------------------------------------------------------------------------------#

def self.pad_string(a_string, a_suffix, a_width)
  a_suffix.length ? a_string + " " * (a_width - a_string.length - a_suffix.length) + a_suffix : a_string.dup
end


#----------------------------------------------------------------------------------------------------------------------#  
  
def self.format_line(text, prefix, only_first_line_prefix=false, suffix='', alternate_prefix='')
  the_suffix = suffix.length ? " " + suffix : ""
  text_width = terminal_width - 1 - the_suffix.length
  title_array = text.split(" ")
  result = []
  current_line = prefix.dup
  current_prefix = 
    only_first_line_prefix \
    ? alternate_prefix + " " * (prefix.length - alternate_prefix.length) \
    : prefix.dup
  
  title_array.each do |w|
    (current_line.length + w.length + 1 > text_width) \
      && result << pad_string(current_line, suffix, terminal_width) \
      && current_line = current_prefix.dup
    current_line << " " << w
  end
  
  current_line.length > current_prefix.length && result << pad_string(current_line, suffix, terminal_width)
  result.join("\n")
end

#----------------------------------------------------------------------------------------------------------------------#  

def self.heading(a_text, a_delimiter = '=')
  Box.new { self.top = self.bottom = a_delimiter; para a_text}.to_s
end


#----------------------------------------------------------------------------------------------------------------------#  

def self.h1(a_text)
  self.heading(a_text, '#')
end


#----------------------------------------------------------------------------------------------------------------------#  

def self.h2(a_text)
  self.heading(a_text, '=')
end


#----------------------------------------------------------------------------------------------------------------------#  

def self.h3(a_text)
  self.heading(a_text, '-')
end


#----------------------------------------------------------------------------------------------------------------------#  

class Box
  attr_accessor :left, :right, :top, :bottom
  def initialize *a, &b
    @left = @right = '#'
    @top = @bottom = '='
    @width = PrettyComment.terminal_width
    @linebuffer = []
    cloaker(&b).bind(self).call(*a) if b
  end


#----------------------------------------------------------------------------------------------------------------------#  

  def para(a_string)
    @linebuffer << PrettyComment::format_line(a_string, left, false, right)
  end


#----------------------------------------------------------------------------------------------------------------------#  

  def hline(a_char = @top)
    @linebuffer << PrettyComment.separator(a_char)
  end


#----------------------------------------------------------------------------------------------------------------------#  

  def to_s
    newline = "\n"
    PrettyComment::separator(top) + newline + @linebuffer.join("\n") + newline + PrettyComment::separator(bottom)
  end

#----------------------------------------------------------------------------------------------------------------------#  

  def cloaker &b
    (class << self; self; end).class_eval do
      define_method :cloaker_, &b
      meth = instance_method :cloaker_
      remove_method :cloaker_
      meth
    end
  end  
end


#----------------------------------------------------------------------------------------------------------------------#  

end


