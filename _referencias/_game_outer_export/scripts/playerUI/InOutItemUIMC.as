package playerUI
{
   import ControlClass.MJInput;
   import ControlClass.TitleBox;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2320")]
   public dynamic class InOutItemUIMC extends MovieClip
   {
      
      public var cmdLeft:SimpleButton;
      
      public var bg:MovieClip;
      
      public var txtTitle:TextField;
      
      public var cmdRight:SimpleButton;
      
      public var input:MJInput;
      
      public var cmdCancel:MainButton;
      
      public var cmdSure:MainButton;
      
      public var title:TitleBox;
      
      public function InOutItemUIMC()
      {
         super();
         obf_0_6_n_299();
         obf_O_Y_3977();
      }
      
      internal function obf_O_Y_3977() : *
      {
         try
         {
            cmdCancel["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdCancel.emphasized = false;
         cmdCancel.enabled = true;
         cmdCancel.label = "obf___4932";
         cmdCancel.labelPlacement = "right";
         cmdCancel.selected = false;
         cmdCancel.toggle = false;
         cmdCancel.visible = true;
         try
         {
            cmdCancel["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_6_n_299() : *
      {
         try
         {
            cmdSure["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSure.emphasized = false;
         cmdSure.enabled = true;
         cmdSure.label = "obf___4891";
         cmdSure.labelPlacement = "right";
         cmdSure.selected = false;
         cmdSure.toggle = false;
         cmdSure.visible = true;
         try
         {
            cmdSure["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

