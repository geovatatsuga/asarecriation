package com.sunweb.game.rpg.playerUI.ranking
{
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import flash.events.TextEvent;
   import playerUI.RankItemBox;
   
   public class RankingItem extends RankItemBox
   {
      
      public function RankingItem()
      {
         super();
         txtRank.mouseEnabled = false;
         txtJobName.mouseEnabled = false;
         txtPlayerName.addEventListener(TextEvent.LINK,this.obf_v_a_r_4628);
      }
      
      private function obf_v_a_r_4628(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      public function destroy() : void
      {
         txtPlayerName.removeEventListener(TextEvent.LINK,this.obf_v_a_r_4628);
      }
   }
}

