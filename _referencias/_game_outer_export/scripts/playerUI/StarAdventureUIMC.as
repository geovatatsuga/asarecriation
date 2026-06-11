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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol808")]
   public dynamic class StarAdventureUIMC extends MovieClip
   {
      
      public var obf_2_E_3095:UIScrollBar;
      
      public var bgBox:MovieClip;
      
      public var txtAdventure:TextField;
      
      public var txtAttribute:TextField;
      
      public var txtStarName:TextField;
      
      public var txtAtrrs:TextField;
      
      public var titleBox:MovieClip;
      
      public var txtAdventureExplain:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var obf_9_h_1529:MovieClip;
      
      public var txtStar:TextField;
      
      public var txtStarCond:TextField;
      
      public var txtExplain:TextField;
      
      public var txtDeyTitle:TextField;
      
      public var bgBox2:MovieClip;
      
      public var cmdUp:MainButton;
      
      public var cmdAdventure:MainButton;
      
      public var txtAttrsName:TextField;
      
      public function StarAdventureUIMC()
      {
         super();
         obf_y_Z_3910();
         obf_H_A_1561();
         obf_2_J_2435();
      }
      
      internal function obf_y_Z_3910() : *
      {
         try
         {
            obf_2_E_3095["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_2_E_3095.direction = "vertical";
         obf_2_E_3095.scrollTargetName = "txtAdventureExplain";
         obf_2_E_3095.visible = true;
         try
         {
            obf_2_E_3095["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_2_J_2435() : *
      {
         try
         {
            cmdAdventure["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdAdventure.emphasized = false;
         cmdAdventure.enabled = true;
         cmdAdventure.label = "obf_____4843";
         cmdAdventure.labelPlacement = "right";
         cmdAdventure.selected = false;
         cmdAdventure.toggle = false;
         cmdAdventure.visible = true;
         try
         {
            cmdAdventure["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_H_A_1561() : *
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
         cmdUp.label = "obf_____4844";
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

