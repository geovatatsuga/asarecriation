package playerUI
{
   import adobe.utils.*;
   import fl.controls.UIScrollBar;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4309")]
   public dynamic class RideFusionUIMC extends MovieClip
   {
      
      public var txtLifeApt:TextField;
      
      public var txtCureApt2:TextField;
      
      public var txtScrollBar:UIScrollBar;
      
      public var bagMainRide:IconBarMC;
      
      public var txtDeyConvert:TextField;
      
      public var txtDeyPrompt:TextField;
      
      public var txtDeySpeed2:TextField;
      
      public var cmdFusion:MainButton;
      
      public var txtDeyCureApt:TextField;
      
      public var txtDeyCureApt2:TextField;
      
      public var txtDeyAttackApt:TextField;
      
      public var bagFusionMaterial:IconBarMC;
      
      public var txtQuality2:TextField;
      
      public var txtAttackApt2:TextField;
      
      public var txtAttackApt:TextField;
      
      public var bagSubRide:IconBarMC;
      
      public var txtDeyQuality2:TextField;
      
      public var txtDeyAttackApt2:TextField;
      
      public var txtLevel2:TextField;
      
      public var txtCureApt:TextField;
      
      public var txtDeySpeed:TextField;
      
      public var txtChance:TextField;
      
      public var bagInvertMaterial:IconBarMC;
      
      public var txtDeySubRide:TextField;
      
      public var txtDeyInvertMaterial:TextField;
      
      public var txtSpeed:TextField;
      
      public var txtDeyTitle:TextField;
      
      public var titleBox:MovieClip;
      
      public var txtDefenseApt:TextField;
      
      public var txtDeyLevel2:TextField;
      
      public var txtDeyQuality:TextField;
      
      public var txtLifeApt2:TextField;
      
      public var txtSpeed2:TextField;
      
      public var txtDeyLevel:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var txtDeyLifeApt:TextField;
      
      public var txtDeyDefenseApt2:TextField;
      
      public var txtQuality:TextField;
      
      public var txtDeyLifeApt2:TextField;
      
      public var txtDeyFusionMaterial:TextField;
      
      public var txtDeyDefenseApt:TextField;
      
      public var txtDeyMainRide:TextField;
      
      public var txtLevel:TextField;
      
      public var txtDefenseApt2:TextField;
      
      public var bgBox:MovieClip;
      
      public function RideFusionUIMC()
      {
         super();
         obf_r_V_2223();
         obf_0_8_C_468();
      }
      
      internal function obf_r_V_2223() : *
      {
         try
         {
            cmdFusion["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdFusion.emphasized = false;
         cmdFusion.enabled = true;
         cmdFusion.label = "obf_____4710";
         cmdFusion.labelPlacement = "right";
         cmdFusion.selected = false;
         cmdFusion.toggle = false;
         cmdFusion.visible = true;
         try
         {
            cmdFusion["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_8_C_468() : *
      {
         try
         {
            txtScrollBar["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         txtScrollBar.direction = "vertical";
         txtScrollBar.scrollTargetName = "txtDeyPrompt";
         txtScrollBar.visible = true;
         try
         {
            txtScrollBar["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

