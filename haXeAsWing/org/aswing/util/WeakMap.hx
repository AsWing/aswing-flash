package org.aswing.util;
 
  
#if flash
import flash.utils.TypedDictionary;
#end


class WeakMap <K, T> {
	
	
	
	#if flash
	/** @private */ private var dictionary:TypedDictionary <K, T>;
	#else
	/** @private */ private var hashKeys: haxe.ds.IntMap<K>;
	/** @private */ private var hashValues: haxe.ds.IntMap<T>;
	#end
	
	/** @private */ private static var nextObjectID:Int = 0;
	
	private var length:Int;
	public function new () {
		
		#if flash
		
		dictionary = new TypedDictionary <K, T> ();
		
		#else
		
		hashKeys = new haxe.ds.IntMap<K> ();
		hashValues = new haxe.ds.IntMap<T> ();
		
		#end
		length = 0;
		
	}
	
	
	public inline function exists (key:K):Bool {
		
		#if flash
		
		return dictionary.exists (key);
		
		#else
		
		return hashValues.exists (getID (key));
		
		#end
		
	}
	
	
	public inline function get (key:K):T {
		
		#if flash
		
		return dictionary.get (key);
		
		#else
		
		return hashValues.get (getID (key));
		
		#end
		
	}
	
	
	/** @private */ private inline function getID (key:K):Int {
		
		#if cpp
		
		return untyped __global__.__hxcpp_obj_id (key);
		
		#elseif !flash
		
		if (untyped key.___id___ == null) {
			
			untyped key.___id___ = nextObjectID ++;
			
			if (nextObjectID == #if neko 0x3fffffff #else 0x7fffffff #end) {
				
				nextObjectID = 0;
				
			}
			
		}
		
		return untyped key.___id___;
		
		#else
		
		return 0;
		
		#end
		
	}
	
	
	public inline function iterator ():Iterator <T> {
		
		#if flash
		
		var values:Array <T> = new Array <T> ();
		
		for (key in dictionary.iterator ()) {
			
			values.push (dictionary.get (key));
			
		}
		
		return values.iterator ();
		
		#else
		
		return hashValues.iterator ();
		
		#end
		
	}
	
	
	public inline function keys ():Iterator <K> {
		
		#if flash
		
		return dictionary.iterator ();
		
		#else
		
		return hashKeys.iterator ();
		
		#end
		
	}
	
	
	public inline function remove (key:K):Void {
		
		#if flash
		
		dictionary.delete (key);
		
		#else
		
		var id = getID (key);
		
		hashKeys.remove (id);
		hashValues.remove (id);
		
		#end
		
	}
	
	
	public inline function set (key:K, value:T):Void {
		
		#if flash
		
		dictionary.set (key, value);
		
		#else
		
		var id = getID (key);
		
		hashKeys.set (id, key);
		hashValues.set (id, value);
		
		#end
		
	}
	
	
	 
 	//-------------------public methods--------------------

 	/**
  	 * Returns the number of keys in this HashMap.
  	 */
 	public function size():Int{
  		return length;
 	}

 	/**
  	 * Returns if this HashMap maps no keys to values.
  	 */
 	public function isEmpty():Bool{
  		return (length==0);
 	}

 
 	
 	/**
 	 * Call func(key) for each key.
 	 * @param func the function to call
 	 */
 	public function eachKey(func:Dynamic -> Void):Void {
	 
  		for(i in keys()){
  			func(i);
  		}
 	}
 	
 	/**
 	 * Call func(value) for each value.
 	 * @param func the function to call
 	 */ 	
 	public function eachValue(func:Dynamic -> Void):Void{ 
  		for(i in iterator()){
  			func(i);
  		}
 	}
  
 	/**
  	 * Tests if some key maps into the specified value in this HashMap.
  	 * This operation is more expensive than the containsKey method.
  	 */
 	public function containsValue(value:T):Bool{
  		var itr:Iterator<T> =  iterator();	
  		for(i in itr){
   			if(i == value){
    			return true;
   			}
  		}
 		return false;
 	}

 	/**
  	 * Tests if the specified object is a key in this HashMap.
  	 * This operation is very fast if it is a string.
     * @param   key   The key whose presence in this map is to be tested
     * @return <tt>true</tt> if this map contains a mapping for the specified
  	 */
 	public function containsKey(key:Dynamic ):Bool {
 
  		return exists(key);
 	}
	
 	 
 	
 	/**
 	 * Same functionity method with different name to <code>get</code>.
 	 * 
     * @param   key the key whose associated value is to be returned.
     * @return  the value to which this map maps the specified key, or
     *          <tt>null</tt> if the map contains no mapping for this key
     *           or it is null value originally.
 	 */
 	public function getValue(key:Dynamic):Dynamic{
 		return get(key);
 	}

 	/**
 	 * Associates the specified value with the specified key in this map. 
 	 * If the map previously contained a mapping for this key, the old value is replaced. 
 	 * If value is null, means remove the key from the map.
     * @param key key with which the specified value is to be associated.
     * @param value value to be associated with the specified key. null to remove the key.
     * @return previous value associated with specified key, or <tt>null</tt>
     *	       if there was no mapping for key.  A <tt>null</tt> return can
     *	       also indicate that the HashMap previously associated
     *	       <tt>null</tt> with the specified key.
  	 */
 	public function put(key:K, value:T):T {
		if (!exists(key)) length++;
		set(key, value);
		return value;
 	}
 
 	/**
 	 * Clears this HashMap so that it contains no keys no values.
 	 */
 	public function clear():Void{
		var itr:Iterator<K> =  keys();	
  		for(i in itr){
   			remove(i);
  		}
 	}

 	/**
 	 * Return a same copy of WeakMap object
 	 */
 	public function clone():WeakMap<K,T>{
  		var temp:WeakMap<K,T> = new WeakMap<K,T>();
  		var itr:Iterator<K> =  keys();	
  		for(i in itr){
   			 temp.put(i , get(i));
  		}
  		return temp;
 	}
}