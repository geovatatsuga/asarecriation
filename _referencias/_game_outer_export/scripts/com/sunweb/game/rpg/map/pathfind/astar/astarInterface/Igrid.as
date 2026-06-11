package com.sunweb.game.rpg.map.pathfind.astar.astarInterface
{
   public interface Igrid
   {
      
      function get numRows() : int;
      
      function get startNode() : obf_G_L_1125;
      
      function get endNode() : obf_G_L_1125;
      
      function get numCols() : int;
      
      function get nodes() : Array;
   }
}

