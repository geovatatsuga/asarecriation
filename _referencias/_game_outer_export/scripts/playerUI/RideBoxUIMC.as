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
   import mcRes.AssembleLuckBox;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1161")]
   public dynamic class RideBoxUIMC extends MovieClip
   {
      
      public var barExp:MovieClip;
      
      public var txtDeyPrompt:TextField;
      
      public var txtAllAptUp:TextField;
      
      public var barFood:IconBarMC;
      
      public var txtDeyAttackApt:TextField;
      
      public var txtDeyCureApt:TextField;
      
      public var rideDepot:MainButton;
      
      public var txtPage:TextField;
      
      public var txtDeyAllAptUp:TextField;
      
      public var cmdAddDefenseApt:SimpleButton;
      
      public var txtAttackApt:TextField;
      
      public var selectedBox:MovieClip;
      
      public var txtCureApt:TextField;
      
      public var rideBag1:MovieClip;
      
      public var rideBag2:MovieClip;
      
      public var rideBag3:MovieClip;
      
      public var rideBag4:MovieClip;
      
      public var rideBag5:MovieClip;
      
      public var bgBox:MovieClip;
      
      public var rideEquip:MainButton;
      
      public var titleBox:MovieClip;
      
      public var txtDefenseApt:TextField;
      
      public var txtDeyQuality:TextField;
      
      public var txtRideAssChanse:TextField;
      
      public var obf_Q_0_1896:AssembleLuckBox;
      
      public var txtDeyDefenseApt:TextField;
      
      public var txtDeyExp:TextField;
      
      public var txtQuality:TextField;
      
      public var cmdUp:MainButton;
      
      public var cmdAddAttackApt:SimpleButton;
      
      public var txtExp:TextField;
      
      public var cmdAddLifeApt:SimpleButton;
      
      public var pointRideImage:MovieClip;
      
      public var txtDeyLevelUp:TextField;
      
      public var txtDeySpeedUp:TextField;
      
      public var txtDeySpeed:TextField;
      
      public var bagRideMaterial0:IconBarMC;
      
      public var bagRideMaterial2:IconBarMC;
      
      public var txtDeyTitle:TextField;
      
      public var bagRideMaterial1:IconBarMC;
      
      public var txtSpeedUp:TextField;
      
      public var txtSpeed:TextField;
      
      public var cmdFood:MainButton;
      
      public var cmdAddCureApt:SimpleButton;
      
      public var txtDeyRideAss:TextField;
      
      public var cmdRideAss:MainButton;
      
      public var txtDeyLevel:TextField;
      
      public var txtDeyLifeApt:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var txtDeyRideMaterial:TextField;
      
      public var txtLevel:TextField;
      
      public var cmdRideFusion:MainButton;
      
      public var txtLifeApt:TextField;
      
      public var cmdDown:MainButton;
      
      public var cmdSort:MainButton;
      
      public function RideBoxUIMC()
      {
         super();
         obf_G_8_3419();
         obf_d_H_1123();
         obf_H_Q_4622();
         obf_V_3762();
         obf_0_7_s_709();
         obf_4_K_3207();
         obf_f_m_1788();
         obf_G_a_4525();
      }
      
      internal function obf_0_7_s_709() : *
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
         cmdUp.label = "obf____4858";
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
      
      internal function obf_G_8_3419() : *
      {
         try
         {
            cmdFood["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdFood.emphasized = false;
         cmdFood.enabled = true;
         cmdFood.label = "obf_____4775";
         cmdFood.labelPlacement = "right";
         cmdFood.selected = false;
         cmdFood.toggle = false;
         cmdFood.visible = true;
         try
         {
            cmdFood["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_V_3762() : *
      {
         try
         {
            rideEquip["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         rideEquip.emphasized = false;
         rideEquip.enabled = true;
         rideEquip.label = "obf_____4711";
         rideEquip.labelPlacement = "right";
         rideEquip.selected = false;
         rideEquip.toggle = false;
         rideEquip.visible = true;
         try
         {
            rideEquip["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_G_a_4525() : *
      {
         try
         {
            rideDepot["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         rideDepot.emphasized = false;
         rideDepot.enabled = true;
         rideDepot.label = "obf____4855";
         rideDepot.labelPlacement = "right";
         rideDepot.selected = false;
         rideDepot.toggle = false;
         rideDepot.visible = true;
         try
         {
            rideDepot["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_d_H_1123() : *
      {
         try
         {
            cmdRideAss["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdRideAss.emphasized = false;
         cmdRideAss.enabled = true;
         cmdRideAss.label = "obf_____4721";
         cmdRideAss.labelPlacement = "right";
         cmdRideAss.selected = false;
         cmdRideAss.toggle = false;
         cmdRideAss.visible = true;
         try
         {
            cmdRideAss["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_H_Q_4622() : *
      {
         try
         {
            cmdRideFusion["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdRideFusion.emphasized = false;
         cmdRideFusion.enabled = true;
         cmdRideFusion.label = "obf_____4779";
         cmdRideFusion.labelPlacement = "right";
         cmdRideFusion.selected = false;
         cmdRideFusion.toggle = false;
         cmdRideFusion.visible = true;
         try
         {
            cmdRideFusion["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_4_K_3207() : *
      {
         try
         {
            cmdDown["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdDown.emphasized = false;
         cmdDown.enabled = true;
         cmdDown.label = "obf____4854";
         cmdDown.labelPlacement = "right";
         cmdDown.selected = false;
         cmdDown.toggle = false;
         cmdDown.visible = true;
         try
         {
            cmdDown["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_f_m_1788() : *
      {
         try
         {
            cmdSort["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSort.emphasized = false;
         cmdSort.enabled = true;
         cmdSort.label = "obf___4939";
         cmdSort.labelPlacement = "right";
         cmdSort.selected = false;
         cmdSort.toggle = false;
         cmdSort.visible = true;
         try
         {
            cmdSort["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

