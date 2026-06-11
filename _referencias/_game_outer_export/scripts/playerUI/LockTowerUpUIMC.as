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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3371")]
   public dynamic class LockTowerUpUIMC extends MovieClip
   {
      
      public var bg:MovieClip;
      
      public var txtTip1:TextField;
      
      public var txtTip2:TextField;
      
      public var txtTitle:TextField;
      
      public var cmdB1:MainButton;
      
      public var cmdB2:MainButton;
      
      public var cmdB3:MainButton;
      
      public var icon:IconBarMC;
      
      public var cmdClose:SimpleButton;
      
      public function LockTowerUpUIMC()
      {
         super();
         obf_2_7_3940();
         obf_p_4664();
         obf_K_I_3883();
      }
      
      internal function obf_K_I_3883() : *
      {
         try
         {
            cmdB3["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdB3.emphasized = false;
         cmdB3.enabled = true;
         cmdB3.label = "cmdB3";
         cmdB3.labelPlacement = "right";
         cmdB3.selected = false;
         cmdB3.toggle = false;
         cmdB3.visible = true;
         try
         {
            cmdB3["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_2_7_3940() : *
      {
         try
         {
            cmdB1["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdB1.emphasized = false;
         cmdB1.enabled = true;
         cmdB1.label = "cmdB1";
         cmdB1.labelPlacement = "right";
         cmdB1.selected = false;
         cmdB1.toggle = false;
         cmdB1.visible = true;
         try
         {
            cmdB1["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_p_4664() : *
      {
         try
         {
            cmdB2["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdB2.emphasized = false;
         cmdB2.enabled = true;
         cmdB2.label = "cmdB2";
         cmdB2.labelPlacement = "right";
         cmdB2.selected = false;
         cmdB2.toggle = false;
         cmdB2.visible = true;
         try
         {
            cmdB2["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

