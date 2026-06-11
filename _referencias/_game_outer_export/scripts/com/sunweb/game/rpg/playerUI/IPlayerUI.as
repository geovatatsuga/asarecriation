package com.sunweb.game.rpg.playerUI
{
   public interface IPlayerUI
   {
      
      function get mouseOn() : Boolean;
      
      function get uiIndex() : int;
      
      function initDiversity() : void;
      
      function showUI() : void;
      
      function closeUI() : void;
      
      function destroy() : void;
   }
}

