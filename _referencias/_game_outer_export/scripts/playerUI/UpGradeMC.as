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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2175")]
   public dynamic class UpGradeMC extends MovieClip
   {
      
      public var upLv:TextField;
      
      public var upName:TextField;
      
      public var txtUpExplain:TextField;
      
      public var txtUpMaterial:TextField;
      
      public var cmdUp:MainButton;
      
      public var txtUpName:TextField;
      
      public var txtUpLv:TextField;
      
      public var upIcon1:IconBarMC;
      
      public var upIcon2:IconBarMC;
      
      public function UpGradeMC()
      {
         super();
         obf_o_d_3531();
      }
      
      internal function obf_o_d_3531() : *
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
         cmdUp.label = "obf_____4716";
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

