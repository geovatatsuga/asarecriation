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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4717")]
   public dynamic class BloodyWarUIMC extends MovieClip
   {
      
      public var txtAttackValue:TextField;
      
      public var txtAttr:TextField;
      
      public var txtAttackLv:TextField;
      
      public var txtAttackTempValue:TextField;
      
      public var txtTip:TextField;
      
      public var txtAttackLevel:TextField;
      
      public var expAttackBar:MovieClip;
      
      public var txtDefenseValue:TextField;
      
      public var txtDefenseTemp:TextField;
      
      public var txtAttackInfo:TextField;
      
      public var txtDefenseTempValue:TextField;
      
      public var expDefenseBar:MovieClip;
      
      public var txtExpAttack:TextField;
      
      public var txtDefense:TextField;
      
      public var txtDefenseLevel:TextField;
      
      public var txtInfo:TextField;
      
      public var bg:MovieClip;
      
      public var txtAttackTemp:TextField;
      
      public var txtTitle:TextField;
      
      public var cmdChangeDefense:MainButton;
      
      public var txtAttack:TextField;
      
      public var txtDefenseLv:TextField;
      
      public var cmdAttackUp:MainButton;
      
      public var cmdClose:SimpleButton;
      
      public var cmdDefenseUp:MainButton;
      
      public var titleBox:MovieClip;
      
      public var cmdChangeAttack:MainButton;
      
      public var txtExpDefense:TextField;
      
      public var txtDefenseInfo:TextField;
      
      public function BloodyWarUIMC()
      {
         super();
         obf_b_3_4115();
         obf_P_j_3044();
         obf_G_i_2274();
         obf_8_g_4328();
      }
      
      internal function obf_8_g_4328() : *
      {
         try
         {
            cmdChangeDefense["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdChangeDefense.emphasized = false;
         cmdChangeDefense.enabled = true;
         cmdChangeDefense.label = "obf___4935";
         cmdChangeDefense.labelPlacement = "right";
         cmdChangeDefense.selected = false;
         cmdChangeDefense.toggle = false;
         cmdChangeDefense.visible = true;
         try
         {
            cmdChangeDefense["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_P_j_3044() : *
      {
         try
         {
            cmdDefenseUp["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdDefenseUp.emphasized = false;
         cmdDefenseUp.enabled = true;
         cmdDefenseUp.label = "obf___4912";
         cmdDefenseUp.labelPlacement = "right";
         cmdDefenseUp.selected = false;
         cmdDefenseUp.toggle = false;
         cmdDefenseUp.visible = true;
         try
         {
            cmdDefenseUp["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_G_i_2274() : *
      {
         try
         {
            cmdChangeAttack["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdChangeAttack.emphasized = false;
         cmdChangeAttack.enabled = true;
         cmdChangeAttack.label = "obf___4935";
         cmdChangeAttack.labelPlacement = "right";
         cmdChangeAttack.selected = false;
         cmdChangeAttack.toggle = false;
         cmdChangeAttack.visible = true;
         try
         {
            cmdChangeAttack["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_b_3_4115() : *
      {
         try
         {
            cmdAttackUp["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdAttackUp.emphasized = false;
         cmdAttackUp.enabled = true;
         cmdAttackUp.label = "obf___4912";
         cmdAttackUp.labelPlacement = "right";
         cmdAttackUp.selected = false;
         cmdAttackUp.toggle = false;
         cmdAttackUp.visible = true;
         try
         {
            cmdAttackUp["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

