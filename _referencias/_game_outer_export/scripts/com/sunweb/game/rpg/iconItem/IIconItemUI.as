package com.sunweb.game.rpg.iconItem
{
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   
   public interface IIconItemUI extends IPlayerUI
   {
      
      function getIconItemBags() : Array;
      
      function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void;
      
      function dbclickIconItemBag(param1:IconItemBag) : void;
      
      function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void;
      
      function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void;
   }
}

