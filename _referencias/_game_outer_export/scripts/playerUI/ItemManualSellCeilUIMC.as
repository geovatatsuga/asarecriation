package playerUI
{
   import adobe.utils.*;
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.sampler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol5045")]
   public dynamic class ItemManualSellCeilUIMC extends MovieClip
   {
      
      public var bgBox:MovieClip;
      
      public var txtExplain:TextField;
      
      public var cmdOne:MainButton;
      
      public var cmdAll:MainButton;
      
      public var cmdClose:SimpleButton;
      
      public function ItemManualSellCeilUIMC()
      {
         super();
         obf_q_v_746();
         obf_q_r_2704();
      }
      
      internal function obf_q_r_2704() : *
      {
         try
         {
            cmdAll["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdAll.emphasized = false;
         cmdAll.enabled = true;
         cmdAll.label = "obf_____4801";
         cmdAll.labelPlacement = "right";
         cmdAll.selected = false;
         cmdAll.toggle = false;
         cmdAll.visible = true;
         try
         {
            cmdAll["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_q_v_746() : *
      {
         try
         {
            cmdOne["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdOne.emphasized = false;
         cmdOne.enabled = true;
         cmdOne.label = "obf_____4835";
         cmdOne.labelPlacement = "right";
         cmdOne.selected = false;
         cmdOne.toggle = false;
         cmdOne.visible = true;
         try
         {
            cmdOne["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

