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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol741")]
   public dynamic class WorldUIMC extends MovieClip
   {
      
      public var remark:TextField;
      
      public var effectPoint1:MovieClip;
      
      public var effectPoint2:MovieClip;
      
      public var effectPoint3:MovieClip;
      
      public var effectPoint4:MovieClip;
      
      public var effectPoint5:MovieClip;
      
      public var txtWorldName:TextField;
      
      public var txtExploreName:TextField;
      
      public var txtDeyTitle:TextField;
      
      public var cmdCelerity:MainButton;
      
      public var materialIconBar:IconBarMC;
      
      public var leavingsTime:TextField;
      
      public var worldName:TextField;
      
      public var cmdAugury:MainButton;
      
      public var exploreName:TextField;
      
      public var cmdAward:MainButton;
      
      public var titleBox:MovieClip;
      
      public var bgBox:MovieClip;
      
      public var cmdClose:SimpleButton;
      
      public var txtDatLand1:TextField;
      
      public var txtDatLand2:TextField;
      
      public var txtDatLand3:TextField;
      
      public var txtDatLand4:TextField;
      
      public var txtDatLand5:TextField;
      
      public var cmdMandLand3:SimpleButton;
      
      public var cmdMandLand4:SimpleButton;
      
      public var cmdMandLand5:SimpleButton;
      
      public var txtValue:TextField;
      
      public var cmdMandLand1:SimpleButton;
      
      public var cmdMandLand2:SimpleButton;
      
      public var txtLvValue:TextField;
      
      public var cmdExplore:MainButton;
      
      public function WorldUIMC()
      {
         super();
         obf_0_2_P_191();
         obf_b_N_1547();
         obf_j_r_1148();
      }
      
      internal function obf_b_N_1547() : *
      {
         try
         {
            cmdAugury["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdAugury.emphasized = false;
         cmdAugury.enabled = true;
         cmdAugury.label = "obf_____4782";
         cmdAugury.labelPlacement = "right";
         cmdAugury.selected = false;
         cmdAugury.toggle = false;
         cmdAugury.visible = true;
         try
         {
            cmdAugury["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_2_P_191() : *
      {
         try
         {
            cmdAward["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdAward.emphasized = false;
         cmdAward.enabled = true;
         cmdAward.label = "obf___4908";
         cmdAward.labelPlacement = "right";
         cmdAward.selected = false;
         cmdAward.toggle = false;
         cmdAward.visible = true;
         try
         {
            cmdAward["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_j_r_1148() : *
      {
         try
         {
            cmdCelerity["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdCelerity.emphasized = false;
         cmdCelerity.enabled = true;
         cmdCelerity.label = "obf_____4789";
         cmdCelerity.labelPlacement = "right";
         cmdCelerity.selected = false;
         cmdCelerity.toggle = false;
         cmdCelerity.visible = true;
         try
         {
            cmdCelerity["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

