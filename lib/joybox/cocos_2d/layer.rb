module Joybox::Cocos2D

  class Layer < CCLayer

    touch_states = [:began, :moved, :ended, :cancelled]
    
      touch_states.each do |touch_state|

        define_method("on_touches_#{touch_state}") do |&block|

          self.isTouchEnabled = true if block_given?

          instance_variable_set("@on_touches_#{touch_state}_block", block)
      end
    end


    def self.enable_scene

      define_singleton_method(:scene) do 

        scene = CCScene.new

        menu_layer = self.new

        scene << menu_layer
      end
    end


    def onEnter

      super

      on_enter if defined? (on_enter)
    end


    def schedule_update(&block)

      @schedule_update_block = block if block_given?

      scheduleUpdate
    end


    def update(dt)

      @schedule_update_block.call(dt) if @schedule_update_block
    end


    # These methods can't be autogenerated using metaprogramming
    # because Objective-C will call them
    def ccTouchesBegan(touches, withEvent: event)

      @on_touches_began_block.call(touches, event) if @on_touches_began_block
    end

    def ccTouchesMoved(touches, withEvent: event)

      @on_touches_moved_block.call(touches, event) if @on_touches_moved_block
    end

    def ccTouchesEnded(touches, withEvent: event)

      @on_touches_ended_block.call(touches, event) if @on_touches_ended_block
    end

    def ccTouchesCancelled(touches, withEvent: event)

      @on_touches_cancelled_block.call(touches, event) if @on_touches_cancelled_block
    end

  end

end