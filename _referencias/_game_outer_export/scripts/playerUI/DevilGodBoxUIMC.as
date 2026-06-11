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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2054")]
   public dynamic class DevilGodBoxUIMC extends MovieClip
   {
      
      public var growBar:MovieClip;
      
      public var cmdEatPet:MainButton;
      
      public var txtPower:TextField;
      
      public var pointModle:MovieClip;
      
      public var bgBox:MovieClip;
      
      public var powerBar:MovieClip;
      
      public var txtAttrs:TextField;
      
      public var cmdUseMoney:MainButton;
      
      public var skillBag0:SkillShowBoxUIMC;
      
      public var skillBag1:SkillShowBoxUIMC;
      
      public var skillBag2:SkillShowBoxUIMC;
      
      public var cmdClose:SimpleButton;
      
      public var titleBox:MovieClip;
      
      public var txtGrow:TextField;
      
      public var txtSkills:TextField;
      
      public var bgBox2:MovieClip;
      
      public var bgBox3:MovieClip;
      
      public var txtDeyTitle:TextField;
      
      public var bgBox1:MovieClip;
      
      public var txtAttrExplain:TextField;
      
      public function DevilGodBoxUIMC()
      {
         super();
         obf_U_P_2018();
         obf_3_X_1615();
      }
      
      internal function obf_U_P_2018() : *
      {
         try
         {
            cmdUseMoney["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdUseMoney.emphasized = false;
         cmdUseMoney.enabled = true;
         cmdUseMoney.label = "obf_____4814";
         cmdUseMoney.labelPlacement = "right";
         cmdUseMoney.selected = false;
         cmdUseMoney.toggle = false;
         cmdUseMoney.visible = true;
         try
         {
            cmdUseMoney["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_3_X_1615() : *
      {
         try
         {
            cmdEatPet["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdEatPet.emphasized = false;
         cmdEatPet.enabled = true;
         cmdEatPet.label = "obf_____4768";
         cmdEatPet.labelPlacement = "right";
         cmdEatPet.selected = false;
         cmdEatPet.toggle = false;
         cmdEatPet.visible = true;
         try
         {
            cmdEatPet["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

