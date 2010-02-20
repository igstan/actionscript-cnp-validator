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
        
        private var _year:String;
        
        private var _month:String;
        
        private var _day:String;
        
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
        
        
        public static function init(_:ISystemManager):void
        {
            monthMethods.forEach(function (month:String, i:int, _:Array):void {
                var monthIndex:String = (i < 9 ? "0" : "") + (i + 1).toFixed();
                
                prototype[month] = function():CnpGenerator {
                    this._month = monthIndex;
                    return this;
                };
            });
        };

        public function generateCnp():String
        {
            return genderDigit() + birthDate();
        }
        
        protected function genderDigit():String
        {
            return isMale ? "1" : "2";
        }
        
        protected function birthDate():String
        {
            return renderYear() + renderMonth() + renderDay();
        }
        
        protected function renderYear():String
        {
            if (_year === null) {
                _year = generateRandomYear();
            }
            
            return _year;
        }
        
        protected function renderMonth():String
        {
            return month;
        }
        
        protected function renderDay():String
        {
            return _day;
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
        
        public function birthYear(year:int):CnpGenerator
        {
            _year = year.toFixed().substring(2, 4);
            return this;
        }
        
        protected function generateRandomYear():String
        {
            return "87";
        }
        
        protected function get month():String
        {
            if (_month === null) {
                _month = generateRandomMonth();
            }
            
            return _month;
        }
        
        protected function generateRandomMonth():String
        {
            return "06";
        }
        
        public function day(day:int):CnpGenerator
        {
            checkDayValidity(day);
            
            this._day = (day < 10 ? "0" : "") + day.toFixed();
            return this;
        }
        
        protected function checkDayValidity(day:int):void
        {
            if (day < 1 || day > 31) {
                throw new ArgumentError();
            }
            
            if (month == "02") {
                if (!isLeapYear(renderYear()) && day > 28) {
                    throw new ArgumentError();
                } else if (day > 29) {
                    throw new ArgumentError();
                }
            }
        }
        
        protected function isLeapYear(year:String):Boolean
        {
            var yearAsInt:int = parseInt("20" + year, 10);
            
            return  yearAsInt % 400 === 0
                || (yearAsInt % 100 !== 0 && yearAsInt % 4 === 0);
        }
    }
}
