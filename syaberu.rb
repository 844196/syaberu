#!/usr/bin/env ruby

require 'readline'

class Speaker
  def initialize
    yield(self)
  end

  def talk
    while text = Readline.readline('> ', true)
      @mouth.move(text)
    end
  end

  def set_mouth(component)
    @mouth = component.new
  end
  alias :mouth :set_mouth

  def self.talk(&block)
    new(&block).talk
  end
end

module Mouth
  class Base
    def move(text)
      system('say', '-v', @voice.to_s, text)
    end
  end

  class Kyoko < Base
    def initialize
      @voice = :Kyoko
    end
  end

  class Otoya < Base
    def initialize
      @voice = :Otoya
    end
  end
end

Speaker.talk do |speaker|
  speaker.mouth Mouth::Kyoko
end
