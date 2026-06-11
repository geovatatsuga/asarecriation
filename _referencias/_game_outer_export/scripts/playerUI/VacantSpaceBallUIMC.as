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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol866")]
   public dynamic class VacantSpaceBallUIMC extends MovieClip
   {
      
      public var cmdClose:SimpleButton;
      
      public var bg:MovieClip;
      
      public var iconUp:IconBarMC;
      
      public var cmdUp:MainButton;
      
      public var txtName:TextField;
      
      public var iconIn:IconBarMC;
      
      public var cmdIn:MainButton;
      
      public function VacantSpaceBallUIMC()
      {
         super();
         obf_o_G_3658();
         obf_1_O_4512();
      }
      
      internal function obf_1_O_4512() : *
      {
         try
         {
            cmdIn["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdIn.emphasized = false;
         cmdIn.enabled = true;
         cmdIn.label = "obf___4924";
         cmdIn.labelPlacement = "right";
         cmdIn.selected = false;
         cmdIn.toggle = false;
         cmdIn.visible = true;
         try
         {
            cmdIn["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_o_G_3658() : *
      {
         try
         {
            cmdUp["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdUp.emphasized = false;
         cmdUp.enabled = true;
         cmdUp.label = "obf___4912";
         cmdUp.labelPlacement = "right";
         cmdUp.selected = false;
         cmdUp.toggle = false;
         cmdUp.visible = true;
         try
         {
            cmdUp["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

