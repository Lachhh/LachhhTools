package com.lachhh.lachhhengine.actor {
	import com.lachhh.lachhhengine.components.ActorComponent;
	import com.lachhh.lachhhengine.components.CollisionComponent;
	import com.lachhh.lachhhengine.components.PhysicComponent;
	import com.lachhh.lachhhengine.components.RenderComponent;
	import com.lachhh.utils.Utils;
	/**
	 * @author LachhhSSD
	 */
	public class Actor {
		
		public var components:Vector.<ActorComponent> = new Vector.<ActorComponent>();
		public var px:Number = 0;
		public var py:Number = 0;
		public var destroyed:Boolean = false;
		public var started:Boolean = false;
		public var enabled:Boolean = true;
		
		public var renderComponent:RenderComponent;
		public var physicComponent:PhysicComponent;
		public var collisionComponent:CollisionComponent;
		
		public function Actor() {
			started = false;
		}
		
		public function start():void {
			started = true;
			var iComponent:ActorComponent;
			for (var i : int = 0; i < components.length; i++) {
				iComponent = components[i];
				iComponent.start();
			}
		}
		
		public function update():void {
			var iComponent:ActorComponent;
			for (var i : int = 0; i < components.length; i++) {
				iComponent = components[i];
				if(iComponent.enabled) iComponent.update();
			}
		}
		
		public function refresh():void {
			var iComponent:ActorComponent;
			for (var i : int = 0; i < components.length; i++) {
				iComponent = components[i];
				iComponent.refresh();
			}
		}
		
		public function destroy():void {
			var iComponent:ActorComponent;
			for (var i : int = 0; i < components.length; i++) {
				iComponent = components[i];
				iComponent.destroy();
			}
			destroyed = true;
			//started = false;
			components = new Vector.<ActorComponent>();
		}
		
		public function addComponent(component:ActorComponent):ActorComponent {
			components.push(component);
			component.actor = this;
			return component;
		}
		
		public function getComponent(componentClass:Class):ActorComponent {
			var component:ActorComponent;
			
			for (var i : int = 0; i < components.length; i++) {
				component = components[i];
				if(Utils.myIsInstanceOfClass(component, componentClass)) {
					return component; 
				}
			}
			return null;
		}
		
		
		public function removeComponent(component:ActorComponent):void {
			if(component == null) return ;
			var iComponent:ActorComponent;
			
			for (var i : int = 0; i < components.length; i++) {
				iComponent = components[i];
				if(iComponent == component) {
					components.splice(i, 1);
					iComponent.destroy();
					return; 
				}
			}
			//throw new Error("Component Not Found");
		}
		
		public function addComponentFromClass(componentClass:Class):ActorComponent {
			var result:ActorComponent = new componentClass();
			addComponent(result);
			return result;
		}
	}
}
