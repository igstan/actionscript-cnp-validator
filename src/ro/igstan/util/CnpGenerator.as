/*
 * Copyright (c) 2010, Ionut Gabriel Stan. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 *    - Redistributions of source code must retain the above copyright notice,
 *      this list of conditions and the following disclaimer.
 *
 *    - Redistributions in binary form must reproduce the above copyright notice,
 *      this list of conditions and the following disclaimer in the documentation
 *      and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

package ro.igstan.util
{
    import mx.managers.ISystemManager;

    [Mixin]
    public dynamic class CnpGenerator
    {
        private var isMale:Boolean = true;
        
        private var userSuppliedYear:int;
        
        private var userSuppliedMonth:int;
        
        private var userSuppliedDay:int;
        
        private static var monthMethods:Array = [
            "january",
            "february",
            "march",
            "april",
            "may",
            "june",
            "july",
            "august",
            "september",
            "october",
            "november",
            "december"
        ];
        
        private var generateMonth:Function;
        
        
        public static function init(_:ISystemManager):void
        {
            monthMethods.forEach(function (month:String, monthIndex:int, _:Array):void {
                prototype[month] = function():CnpGenerator {
                    this.userSuppliedMonth = monthIndex + 1;
                    return this;
                };
            });
        };
        
        public function CnpGenerator(generateMonth:Function = null)
        {
            this.generateMonth = generateMonth || function():int {
                return 6;
            };
        }

        public function generateCnp():String
        {
            return renderGenderDigit() + renderBirthDate();
        }
        
        protected function renderGenderDigit():String
        {
            return isMale ? "1" : "2";
        }
        
        protected function renderBirthDate():String
        {
            return renderYear() + renderMonth() + renderDay();
        }
        
        protected function getYear():int
        {
            return userSuppliedYear || generateRandomYear();
        }
        
        protected function renderYear():String
        {
            return getYear().toFixed().substring(2, 4);
        }
        
        protected function generateRandomYear():int
        {
            return 1987;
        }
        
        public function year(year:int):CnpGenerator
        {
            userSuppliedYear = year;
            return this;
        }
        
        protected function renderMonth():String
        {
            return renderBirthDatePart(getMonth());
        }
        
        protected function renderBirthDatePart(part:int):String
        {
            return (part < 10 ? "0" : "") + part.toFixed();
        }
        
        protected function getMonth():int
        {
            return userSuppliedMonth || generateRandomMonth();
        }
        
        protected function generateRandomMonth():int
        {
            var month:int = generateMonth();
            
            if (getDay() > 29) {
                while (month === 2) {
                    month = generateMonth();
                }
            }
            
            return month;
        }
        
        protected function getDay():int
        {
            return userSuppliedDay || generateRandomDay();
        }
        
        protected function generateRandomDay():int
        {
            return 21;
        }
        
        protected function renderDay():String
        {
            return renderBirthDatePart(getDay());
        }
        
        public function male():CnpGenerator
        {
            isMale = true;
            return this;
        }
        
        public function female():CnpGenerator
        {
            isMale = false;
            return this;
        }
        
        public function day(day:int):CnpGenerator
        {
            checkDayValidity(day);
            
            this.userSuppliedDay = day;
            return this;
        }
        
        protected function checkDayValidity(day:int):void
        {
            if (day < 1 || day > 31) {
                throw new ArgumentError();
            }
            
            if (userSuppliedMonth !== 0 && getMonth() === 2) {
                if (isLeapYear() && day > 29) {
                    throw new ArgumentError();
                } else if (day > 28) {
                    throw new ArgumentError();
                }
            }
        }
        
        protected function isLeapYear():Boolean
        {
            var year:int = getYear();
            
            return  year % 400 === 0
                || (year % 100 !== 0 && year % 4 === 0);
        }
    }
}
