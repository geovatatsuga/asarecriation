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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2467")]
   public dynamic class RefineBoxUIMC extends MovieClip
   {
      
      public var txtDeyEquip:TextField;
      
      public var txtAfterAttrValue:TextField;
      
      public var bagEquip:IconBarMC;
      
      public var cmdAuto:MainButton;
      
      public var txtBeforeAttr:TextField;
      
      public var txtDeyTitle:TextField;
      
      public var txtBeforeAttrValue:TextField;
      
      public var pointRefineIcon:MovieClip;
      
      public var cmdBest:MainButton;
      
      public var bagMaterial0:IconBarMC;
      
      public var bagMaterial1:IconBarMC;
      
      public var bagMaterial2:IconBarMC;
      
      public var bagMaterial3:IconBarMC;
      
      public var bgBox:MovieClip;
      
      public var cmdRefine:MainButton;
      
      public var txtDeyAfterRefine:TextField;
      
      public var txtChance:TextField;
      
      public var txtEquipName:TextField;
      
      public var titleBox:MovieClip;
      
      public var txtDeyChance:TextField;
      
      public var txtAfterAttr:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var refineBG:MovieClip;
      
      public var txtDeyBeforeRefine:TextField;
      
      public var txtDeyCost:TextField;
      
      public var pointCost:MovieClip;
      
      public function RefineBoxUIMC()
      {
         super();
         obf_O_X_2651();
         obf_0_7_J_643();
         obf_f_P_3222();
      }
      
      internal function obf_0_7_J_643() : *
      {
         try
         {
            cmdAuto["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdAuto.emphasized = false;
         cmdAuto.enabled = true;
         cmdAuto.label = "obf___4944";
         cmdAuto.labelPlacement = "right";
         cmdAuto.selected = false;
         cmdAuto.toggle = false;
         cmdAuto.visible = true;
         try
         {
            cmdAuto["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_O_X_2651() : *
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
         cmdRefine.label = "obf_____4708";
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
      
      internal function obf_f_P_3222() : *
      {
         try
         {
            cmdBest["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdBest.emphasized = false;
         cmdBest.enabled = true;
         cmdBest.label = "obf___4968";
         cmdBest.labelPlacement = "right";
         cmdBest.selected = false;
         cmdBest.toggle = false;
         cmdBest.visible = true;
         try
         {
            cmdBest["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

