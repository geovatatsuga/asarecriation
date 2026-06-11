package playerUI
{
   import ControlClass.MJInput;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol340")]
   public dynamic class LocationTagUIMC extends MovieClip
   {
      
      public var cmdSaveTag:MainButton;
      
      public var txtLocation:TextField;
      
      public var bgBox:MovieClip;
      
      public var inputTagName:MJInput;
      
      public var txtDeyTagName:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var obf_L_Q_3141:UIScrollBar;
      
      public var txtDeyTitle:TextField;
      
      public var txtDeyTime:TextField;
      
      public var obf_a_Q_3902:UIScrollBar;
      
      public function LocationTagUIMC()
      {
         super();
         obf_l_897();
         obf_F_E_2628();
         obf_K_a_1879();
         obf_y_O_3317();
      }
      
      internal function obf_K_a_1879() : *
      {
         try
         {
            inputTagName["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         inputTagName.displayAsPassword = false;
         inputTagName.editable = true;
         inputTagName.enabled = true;
         inputTagName.maxChars = 6;
         inputTagName.restrict = "";
         inputTagName.text = "";
         inputTagName.visible = true;
         try
         {
            inputTagName["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_y_O_3317() : *
      {
         try
         {
            obf_L_Q_3141["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_L_Q_3141.direction = "vertical";
         obf_L_Q_3141.scrollTargetName = "txtLocation";
         obf_L_Q_3141.visible = true;
         try
         {
            obf_L_Q_3141["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_F_E_2628() : *
      {
         try
         {
            obf_a_Q_3902["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_a_Q_3902.direction = "horizontal";
         obf_a_Q_3902.scrollTargetName = "";
         obf_a_Q_3902.visible = true;
         try
         {
            obf_a_Q_3902["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_l_897() : *
      {
         try
         {
            cmdSaveTag["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSaveTag.emphasized = false;
         cmdSaveTag.enabled = true;
         cmdSaveTag.label = "obf_______3580";
         cmdSaveTag.labelPlacement = "right";
         cmdSaveTag.selected = false;
         cmdSaveTag.toggle = false;
         cmdSaveTag.visible = true;
         try
         {
            cmdSaveTag["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

