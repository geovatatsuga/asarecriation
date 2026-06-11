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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4668")]
   public dynamic class MakeChipCompUIMC extends MovieClip
   {
      
      public var txtCompound:TextField;
      
      public var comIconGoods:IconBarMC;
      
      public var iconComSuiPian:IconBarMC;
      
      public var cmdRefine:MainButton;
      
      public var txtJing:TextField;
      
      public var iconComMaterial:IconBarMC;
      
      public var jingSuiPicMC:MovieClip;
      
      public var txtSui:TextField;
      
      public var txtName:TextField;
      
      public var txtJingNum:TextField;
      
      public function MakeChipCompUIMC()
      {
         super();
         obf_d_n_3485();
      }
      
      internal function obf_d_n_3485() : *
      {
         try
         {
            cmdRefine["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdRefine.emphasized = false;
         cmdRefine.enabled = true;
         cmdRefine.label = "obf_____4744";
         cmdRefine.labelPlacement = "right";
         cmdRefine.selected = false;
         cmdRefine.toggle = false;
         cmdRefine.visible = true;
         try
         {
            cmdRefine["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

