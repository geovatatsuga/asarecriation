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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4136")]
   public dynamic class TowerBoxUIMC extends MovieClip
   {
      
      public var txtAttr:TextField;
      
      public var txtAdvertScrollBar:UIScrollBar;
      
      public var cmdPearl1:ImageBice;
      
      public var cmdPearl2:ImageBlue;
      
      public var cmdPearl3:ImageYellow;
      
      public var cmdPearl4:ImagePurple;
      
      public var cmdPearl5:ImageRed;
      
      public var obf_q_w_1805:TextField;
      
      public var txtDeyAttr:TextField;
      
      public var txtName:TextField;
      
      public var cmdPearl0:ImageWhite;
      
      public var txtLv:TextField;
      
      public var pointMC:MovieClip;
      
      public var txtDeyTitle:TextField;
      
      public var txtDeyName:TextField;
      
      public var cmd1:MainButton;
      
      public var cmd2:MainButton;
      
      public var cmd3:MainButton;
      
      public var cmd4:MainButton;
      
      public var cmd5:MainButton;
      
      public var cmd6:MainButton;
      
      public var cmdEnter:MainButton;
      
      public var txt1:TextField;
      
      public var txt2:TextField;
      
      public var txt4:TextField;
      
      public var txt5:TextField;
      
      public var txt6:TextField;
      
      public var txt3:TextField;
      
      public var txtAttrNum:TextField;
      
      public var bgBox:MovieClip;
      
      public var txtDeyLv:TextField;
      
      public var titleBox:MovieClip;
      
      public var cmdClose:SimpleButton;
      
      public var txtAdvert:TextField;
      
      public var barMC:MovieClip;
      
      public function TowerBoxUIMC()
      {
         super();
         obf_4_q_1377();
         obf_W_5_844();
         obf_E_v_1585();
         obf_T_y_3854();
         obf_K_S_920();
         obf_U_G_2369();
         obf_N_2_4238();
         obf_0_1_g_471();
      }
      
      internal function obf_W_5_844() : *
      {
         try
         {
            txtAdvertScrollBar["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         txtAdvertScrollBar.direction = "vertical";
         txtAdvertScrollBar.scrollTargetName = "txtAdvert";
         txtAdvertScrollBar.visible = true;
         try
         {
            txtAdvertScrollBar["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_4_q_1377() : *
      {
         try
         {
            cmdEnter["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdEnter.emphasized = false;
         cmdEnter.enabled = true;
         cmdEnter.label = "obf_____4807";
         cmdEnter.labelPlacement = "right";
         cmdEnter.selected = false;
         cmdEnter.toggle = false;
         cmdEnter.visible = true;
         try
         {
            cmdEnter["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_K_S_920() : *
      {
         try
         {
            cmd2["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmd2.emphasized = false;
         cmd2.enabled = true;
         cmd2.label = "obf___4912";
         cmd2.labelPlacement = "right";
         cmd2.selected = false;
         cmd2.toggle = false;
         cmd2.visible = true;
         try
         {
            cmd2["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_U_G_2369() : *
      {
         try
         {
            cmd4["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmd4.emphasized = false;
         cmd4.enabled = true;
         cmd4.label = "obf___4912";
         cmd4.labelPlacement = "right";
         cmd4.selected = false;
         cmd4.toggle = false;
         cmd4.visible = true;
         try
         {
            cmd4["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_N_2_4238() : *
      {
         try
         {
            cmd5["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmd5.emphasized = false;
         cmd5.enabled = true;
         cmd5.label = "obf___4912";
         cmd5.labelPlacement = "right";
         cmd5.selected = false;
         cmd5.toggle = false;
         cmd5.visible = true;
         try
         {
            cmd5["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_1_g_471() : *
      {
         try
         {
            cmd6["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmd6.emphasized = false;
         cmd6.enabled = true;
         cmd6.label = "obf___4912";
         cmd6.labelPlacement = "right";
         cmd6.selected = false;
         cmd6.toggle = false;
         cmd6.visible = true;
         try
         {
            cmd6["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_E_v_1585() : *
      {
         try
         {
            cmd1["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmd1.emphasized = false;
         cmd1.enabled = true;
         cmd1.label = "obf___4912";
         cmd1.labelPlacement = "right";
         cmd1.selected = false;
         cmd1.toggle = false;
         cmd1.visible = true;
         try
         {
            cmd1["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_T_y_3854() : *
      {
         try
         {
            cmd3["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmd3.emphasized = false;
         cmd3.enabled = true;
         cmd3.label = "obf___4912";
         cmd3.labelPlacement = "right";
         cmd3.selected = false;
         cmd3.toggle = false;
         cmd3.visible = true;
         try
         {
            cmd3["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

