# encoding: utf-8
#======================================================================================================================#
require 'terminfo'

#======================================================================================================================#

module PrettyComment
@@width = TermInfo.screen_size[1]
@@styles = {
  'default' => { :left => '#',  :right => '#' }, 
  'c++'     => { :left => '//', :right => '//'},
  'latex'   => { :left => '%',  :right => '%'} 
}
  
#======================================================================================================================#

def self.width
  @@width
end


#----------------------------------------------------------------------------------------------------------------------#

def self.width=(a_width)
  @@width = a_width
end


#----------------------------------------------------------------------------------------------------------------------#

def self.styles
  @@styles
end


#----------------------------------------------------------------------------------------------------------------------#

def self.terminal_width
  TermInfo.screen_size[1]
end


#----------------------------------------------------------------------------------------------------------------------#

def self.separator(char='=', left='#', right='#', width=@@width)
  left + (char * (width - left.length - right.length)) + right
end  


#----------------------------------------------------------------------------------------------------------------------#

def self.small_separator
  separator ('-')
end  


#----------------------------------------------------------------------------------------------------------------------#

def self.comment(comment)
  pad_string("\# #{comment}", "#", width)
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
  
def self.format_line(text, prefix, only_first_line_prefix=false, suffix='', alternate_prefix='', width=@@width)
  the_suffix = suffix.length ? " " + suffix : ""
  text_width = width - 1 - the_suffix.length
  title_array = text.split(" ")
  result = []
  current_line = prefix.dup
  current_prefix = 
    only_first_line_prefix \
    ? alternate_prefix + " " * (prefix.length - alternate_prefix.length) \
    : prefix.dup
  
  title_array.each do |w|
    (current_line.length + w.length + 1 > text_width) \
      && result << pad_string(current_line, suffix, width) \
      && current_line = current_prefix.dup
    current_line << " " << w
  end
  
  current_line.length > current_prefix.length && result << pad_string(current_line, suffix, width)
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
  class << self
    attr_accessor :right, :top, :bottom, :width
  end
  @@left = @@right = '#'
  @@top = @@bottom = '='
  @@width = PrettyComment::width

  attr_accessor :left, :right, :top, :bottom, :width
  def initialize *a, &b
    @left = @@left
    @right = @@right
    @top = @@top
    @bottom = @@bottom
    @width = @@width
    @linebuffer = []
    cloaker(&b).bind(self).call(*a) if b
  end


#----------------------------------------------------------------------------------------------------------------------#  

  def self.left=(a_left)
    @@left = a_left
  end


#----------------------------------------------------------------------------------------------------------------------#  

  def self.right=(a_right)
    @@right = a_right
  end


#----------------------------------------------------------------------------------------------------------------------#  

  def self.top=(a_top)
    @@top = a_top
  end


#----------------------------------------------------------------------------------------------------------------------#  

  def self.bottom=(a_bottom)
    @@bottom = a_bottom
  end


#----------------------------------------------------------------------------------------------------------------------#  

  def self.width=(a_width)
    @@width = a_width
  end


#----------------------------------------------------------------------------------------------------------------------#  

  def self.style=(a_style)
    style = PrettyComment::styles[a_style]
    
    @@left = style[:left]
    @@right = style[:right]
  end


#----------------------------------------------------------------------------------------------------------------------#  

  def box_style(a_style)
    style = PrettyComment.styles[a_style]
    
    @left = style[:left]
    @right = style[:right]
  end


#----------------------------------------------------------------------------------------------------------------------#  

  def box_left(a_left)
    @left = a_left
  end


#----------------------------------------------------------------------------------------------------------------------#  

  def box_right(a_right)
    @right = a_right
  end


#----------------------------------------------------------------------------------------------------------------------#  

  def box_top(a_top)
    @top = a_top
  end


#----------------------------------------------------------------------------------------------------------------------#  

  def box_bottom(a_bottom)
    @bottom = a_bottom
  end


#----------------------------------------------------------------------------------------------------------------------#  

  def box_width(a_width)
    @width = a_width
  end


#----------------------------------------------------------------------------------------------------------------------#  

  def para(a_string)
    @linebuffer << PrettyComment::format_line(a_string, left, false, right, '', width)
  end


#----------------------------------------------------------------------------------------------------------------------#  

  def hline(a_char = @top)
    @linebuffer << PrettyComment.separator(a_char, left, right)
  end


#----------------------------------------------------------------------------------------------------------------------#  

  def heading(a_string, a_char)
    @linebuffer << PrettyComment.separator(a_char, left, right) 
    @linebuffer << PrettyComment::format_line(a_string, left, false, right, '', width)
    @linebuffer << PrettyComment.separator(a_char, left, right) 
  end


#----------------------------------------------------------------------------------------------------------------------#  

  def h1(a_string)
    heading(a_string, "#")
  end


#----------------------------------------------------------------------------------------------------------------------#  

  def h2(a_string)
    heading(a_string, "=")
  end


#----------------------------------------------------------------------------------------------------------------------#  

  def h3(a_string)
    heading(a_string, "-")
  end


#----------------------------------------------------------------------------------------------------------------------#  

  def to_s
    newline = "\n"
    result =  PrettyComment::separator(top, left, right, width) << newline
    result << @linebuffer.join("\n") << newline
    result << PrettyComment::separator(bottom, left, right, width)
  end


#----------------------------------------------------------------------------------------------------------------------#  

  def inspect
    to_s
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


