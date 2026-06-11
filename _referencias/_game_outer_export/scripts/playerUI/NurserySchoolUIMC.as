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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol511")]
   public dynamic class NurserySchoolUIMC extends MovieClip
   {
      
      public var remark:TextField;
      
      public var cmdAward:MainButton;
      
      public var cmdLearn:SimpleButton;
      
      public var leavingsTime:TextField;
      
      public var txtDeyTitle:TextField;
      
      public var titleBox:MovieClip;
      
      public var bgBox:MovieClip;
      
      public var cmdClose:SimpleButton;
      
      public function NurserySchoolUIMC()
      {
         super();
         obf_s_u_p_e_r_186();
      }
      
      internal function obf_s_u_p_e_r_186() : *
      {
         try
         {
            cmdAward["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdAward.emphasized = false;
         cmdAward.enabled = true;
         cmdAward.label = "obf___4908";
         cmdAward.labelPlacement = "right";
         cmdAward.selected = false;
         cmdAward.toggle = false;
         cmdAward.visible = true;
         try
         {
            cmdAward["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

