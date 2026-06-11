package com.brokenfunction.json
{
   public const decodeJson:Function = initDecodeJson();
}

import flash.utils.ByteArray;

function initDecodeJson():Function
{
   var position:uint = 0;
   var byteInput:ByteArray = null;
   var char:uint = 0;
   var strPosition:uint = 0;
   var str:ByteArray = null;
   var charConvert:ByteArray = null;
   var parseNumber:Function = null;
   var parse:Object = null;
   str = new ByteArray();
   charConvert = new ByteArray();
   charConvert.length = 256;
   charConvert[34] = 34;
   charConvert[92] = 92;
   charConvert[47] = 47;
   charConvert[98] = 8;
   charConvert[102] = 12;
   charConvert[110] = 10;
   charConvert[114] = 13;
   charConvert[116] = 9;
   parseNumber = function():Number
   {
      var _loc1_:Number = NaN;
      if(position === 1)
      {
         byteInput.position = 0;
         _loc1_ = parseFloat(byteInput.readUTFBytes(byteInput.length));
         if(isNaN(_loc1_))
         {
            throw new Error("Expected number at position 0");
         }
      }
      else
      {
         strPosition = --position;
         while((char = byteInput[position++]) != 93 && char != 125 && char != 44)
         {
         }
         byteInput.position = strPosition;
         _loc1_ = Number(byteInput.readUTFBytes(position - strPosition - 1));
         position = byteInput.position;
         if(isNaN(_loc1_))
         {
            throw new Error("Expected number at position " + (strPosition - 1));
         }
      }
      return _loc1_;
   };
   parse = {
      34:function():String
      {
         strPosition = position;
         str.position = 0;
         str.length = 0;
         while((char = byteInput[strPosition++]) != 34)
         {
            if(char === 92)
            {
               if(strPosition - 1 > position)
               {
                  byteInput.position = position;
                  byteInput.readBytes(str,str.position,strPosition - 1 - position);
                  str.position = str.length;
                  ++byteInput.position;
                  strPosition = byteInput.position;
                  position = strPosition;
               }
               if((char = byteInput[strPosition++]) === 117)
               {
                  byteInput.position = strPosition;
                  char = parseInt(byteInput.readUTFBytes(4),16);
                  if(char <= 127)
                  {
                     str.writeByte(char);
                  }
                  else if(char < 2047)
                  {
                     str.writeShort(0xC080 | char << 2 & 0x1F00 | char & 0x3F);
                  }
                  else
                  {
                     str.writeByte(0xE0 | char >> 12 & 0x0F);
                     str.writeShort(0x8080 | char << 2 & 0x3F00 | char & 0x3F);
                  }
                  position = strPosition = byteInput.position;
               }
               else
               {
                  if(!(char = charConvert[char]))
                  {
                     throw new Error("Unknown escaped character encountered at position " + (strPosition - 1));
                  }
                  str.position = str.length;
                  str.writeByte(char);
                  position = strPosition;
               }
            }
         }
         if(str.length > 0)
         {
            if(strPosition - 1 > position)
            {
               byteInput.position = position;
               byteInput.readBytes(str,str.position,strPosition - 1 - position);
               byteInput.position++;
            }
            position = strPosition;
            str.position = 0;
            return str.readUTFBytes(str.length);
         }
         byteInput.position = position;
         position = strPosition;
         strPosition = byteInput.position;
         return byteInput.readUTFBytes(position - 1 - strPosition);
      },
      123:function():Object
      {
         var _loc2_:* = undefined;
         if(byteInput[position++] === 125)
         {
            return {};
         }
         var _loc1_:* = {};
         position--;
         while(true)
         {
            _loc2_ = parse[byteInput[position++]]();
            if(byteInput[position++] != 58)
            {
               break;
            }
            _loc1_[_loc2_] = parse[byteInput[position++]]();
            if(byteInput[position++] != 44)
            {
               if(byteInput[position - 1] != 125)
               {
                  throw new Error("Expected , or } at " + (position - 1));
               }
               return _loc1_;
            }
         }
         throw new Error("Expected : at " + position);
      },
      91:function():Object
      {
         if(byteInput[position++] === 93)
         {
            return [];
         }
         var _loc1_:* = [];
         position--;
         do
         {
            _loc1_[_loc1_.length] = parse[byteInput[position++]]();
         }
         while(byteInput[position++] == 44);
         if(byteInput[position - 1] != 93)
         {
            throw new Error("Expected , or ] at " + (position - 1));
         }
         return _loc1_;
      },
      116:function():Boolean
      {
         byteInput.position = position - 1;
         if(byteInput.readInt() === 1953658213)
         {
            position = byteInput.position;
            return true;
         }
         throw new Error("Expected \"true\" at position " + position);
      },
      102:function():Boolean
      {
         byteInput.position = position;
         if(byteInput.readInt() === 1634497381)
         {
            position = byteInput.position;
            return false;
         }
         throw new Error("Expected \"false\" at position " + (position - 1));
      },
      110:function():Object
      {
         byteInput.position = position - 1;
         if(byteInput.readInt() === 1853189228)
         {
            position = byteInput.position;
            return null;
         }
         throw new Error("Expected \"null\" at position " + position);
      },
      110:function():void
      {
         throw new Error("Unexpected end of array at " + position);
      },
      125:function():void
      {
         throw new Error("Unexpected end of object at " + position);
      },
      44:function():void
      {
         throw new Error("Unexpected comma at " + position);
      },
      45:parseNumber,
      48:parseNumber,
      49:parseNumber,
      50:parseNumber,
      51:parseNumber,
      52:parseNumber,
      53:parseNumber,
      54:parseNumber,
      55:parseNumber,
      56:parseNumber,
      57:parseNumber
   };
   return function(param1:*):Object
   {
      var input:* = param1;
      if(input is String)
      {
         byteInput = new ByteArray();
         byteInput.writeUTFBytes(input as String);
      }
      else
      {
         if(!(input is ByteArray))
         {
            throw new Error("Unexpected input <" + input + ">");
         }
         byteInput = input as ByteArray;
      }
      byteInput.position = position = 0;
      byteInput.endian = "bigEndian";
      try
      {
         return parse[byteInput[position++]]();
      }
      catch(e:TypeError)
      {
         if(position - 1 < byteInput.length)
         {
            throw new Error("Internal Stack Trace: " + (e.getStackTrace() || e.message) + "\n\nExternal Stack Trace: Unexpected character " + String.fromCharCode(byteInput[position - 1]) + " (0x" + byteInput[position - 1].toString(16) + ")" + " at position " + (position - 1));
         }
         throw e;
      }
      finally
      {
         str.length = 0;
      }
   };
}
