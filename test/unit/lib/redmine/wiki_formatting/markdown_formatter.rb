# Redmine - project management software
# Copyright (C) 2006-2014  Jean-Philippe Lang
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

require File.expand_path('../../../../../test_helper', __FILE__)

class Redmine::WikiFormatting::MarkdownFormatterTest < ActionView::TestCase
  if Object.const_defined?(:Redcarpet)

  def setup
    @formatter = Redmine::WikiFormatting::Markdown::Formatter
  end

  def test_inline_style
    assert_equal "<p><strong>foo</strong></p>", @formatter.new("**foo**").to_html.strip
  end

  def test_wiki_links_should_be_preserved
    text = 'This is a wiki link: [[Foo]]'
    assert_include '[[Foo]]', @formatter.new(text).to_html
  end

  def test_redmine_links_with_double_quotes_should_be_preserved
    text = 'This is a redmine link: version:"1.0"'
    assert_include 'version:"1.0"', @formatter.new(text).to_html
  end

  def test_should_support_syntax_highligth
    text = <<-STR
~~~ruby
def foo
end
~~~
STR
    assert_select_in @formatter.new(text).to_html, 'pre code.ruby.syntaxhl' do
      assert_select 'span.keyword', :text => 'def'
    end
  end

  def test_external_links_should_have_external_css_class
    text = 'This is a [link](http://example.net/)'
    assert_equal '<p>This is a <a class="external" href="http://example.net/">link</a></p>', @formatter.new(text).to_html.strip
  end

  def test_locals_links_should_not_have_external_css_class
    text = 'This is a [link](/issues)'
    assert_equal '<p>This is a <a href="/issues">link</a></p>', @formatter.new(text).to_html.strip
  end

  end
end
