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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4658")]
   public dynamic class MakeChipMackUIMC extends MovieClip
   {
      
      public var badKeyPic:MovieClip;
      
      public var goodKeyPic:MovieClip;
      
      public var cmdMake1:MainButton;
      
      public var cmdMake10:MainButton;
      
      public function MakeChipMackUIMC()
      {
         super();
         obf_3_V_3440();
         obf_P_3355();
      }
      
      internal function obf_P_3355() : *
      {
         try
         {
            cmdMake10["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdMake10.emphasized = false;
         cmdMake10.enabled = true;
         cmdMake10.label = "制作10个";
         cmdMake10.labelPlacement = "right";
         cmdMake10.selected = false;
         cmdMake10.toggle = false;
         cmdMake10.visible = true;
         try
         {
            cmdMake10["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_3_V_3440() : *
      {
         try
         {
            cmdMake1["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdMake1.emphasized = false;
         cmdMake1.enabled = true;
         cmdMake1.label = "制作1个";
         cmdMake1.labelPlacement = "right";
         cmdMake1.selected = false;
         cmdMake1.toggle = false;
         cmdMake1.visible = true;
         try
         {
            cmdMake1["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

