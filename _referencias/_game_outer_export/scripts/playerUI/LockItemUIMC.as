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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4426")]
   public dynamic class LockItemUIMC extends MovieClip
   {
      
      public var iconName:TextField;
      
      public var bg:MovieClip;
      
      public var cmdOut:MainButton;
      
      public var icon:IconBarMC;
      
      public var txtNumValue:TextField;
      
      public var txtNum:TextField;
      
      public var cmdIn:MainButton;
      
      public function LockItemUIMC()
      {
         super();
         obf_P_4_4249();
         obf_z_I_1598();
      }
      
      internal function obf_z_I_1598() : *
      {
         try
         {
            cmdOut["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdOut.emphasized = false;
         cmdOut.enabled = true;
         cmdOut.label = "obf__4987";
         cmdOut.labelPlacement = "right";
         cmdOut.selected = false;
         cmdOut.toggle = false;
         cmdOut.visible = true;
         try
         {
            cmdOut["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_P_4_4249() : *
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
         cmdIn.label = "obf__4988";
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
   }
}

