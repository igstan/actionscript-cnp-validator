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
        protected static const JANUARY:int   = 1;
        protected static const FEBRUARY:int  = 2;
        protected static const MARCH:int     = 3;
        protected static const APRIL:int     = 4;
        protected static const MAY:int       = 5;
        protected static const JUNE:int      = 6;
        protected static const JULY:int      = 7;
        protected static const AUGUST:int    = 8;
        protected static const SEPTEMBER:int = 9;
        protected static const OCTOBER:int   = 10;
        protected static const NOVEMBER:int  = 11;
        protected static const DECEMBER:int  = 12;
        
        protected static const DAYS_IN_MONTH:Object = {};
        
        {
            DAYS_IN_MONTH[ JANUARY ]   = 31;
            DAYS_IN_MONTH[ MARCH ]     = 31;
            DAYS_IN_MONTH[ APRIL ]     = 30;
            DAYS_IN_MONTH[ MAY ]       = 31;
            DAYS_IN_MONTH[ JUNE ]      = 30;
            DAYS_IN_MONTH[ JULY ]      = 31;
            DAYS_IN_MONTH[ AUGUST ]    = 31;
            DAYS_IN_MONTH[ SEPTEMBER ] = 30;
            DAYS_IN_MONTH[ OCTOBER ]   = 31;
            DAYS_IN_MONTH[ NOVEMBER ]  = 30;
            DAYS_IN_MONTH[ DECEMBER ]  = 31;
        };
        
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
        
        private var generateYear:Function;
        
        
        public static function init(_:ISystemManager):void
        {
            monthMethods.forEach(function (month:String, monthIndex:int, _:Array):void {
                monthIndex += 1;
                
                prototype[month] = function():CnpGenerator {
                    this.checkMonthValidity(monthIndex);
                    
                    this.userSuppliedMonth = monthIndex;
                    return this;
                };
            });
        };
        
        public function CnpGenerator(generators:Object = null)
        {
            generators = generators || {};
            
            this.generateMonth = generators.monthGenerator || function():int {
                return 6;
            };
            
            this.generateYear = generators.yearGenerator || function():int {
                return 1987;
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
            var year:int = generateYear();
            
            if (userSuppliedDay === 29 && getMonth() === FEBRUARY) {
                while (! isLeapYear(year)) {
                    year = generateYear();
                }
            }
            
            return year;
        }
        
        public function year(year:int):CnpGenerator
        {
            userSuppliedYear = year;
            return this;
        }
        
        protected function renderMonth():String
        {
            return zeroFill(getMonth());
        }
        
        protected function zeroFill(part:int):String
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
                while (month === FEBRUARY) {
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
            return zeroFill(getDay());
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
            
            checkMonthAndDayCompatibility(userSuppliedMonth, getMonth(), day);
        }
        
        protected function checkMonthAndDayCompatibility(counterPart:int, month:int, day:int):void
        {
            if (!counterPart) {
                return;
            }
            
            var dayMax:int = month === FEBRUARY
                           ? maxDayForFebruary()
                           : DAYS_IN_MONTH[month];
            
            if (day > dayMax) {
                throw new ArgumentError();
            }
        }
        
        protected function maxDayForFebruary():int
        {
            if (userSuppliedYear && !isLeapYear(getYear())) {
                return 28;
            } else {
                return 29;
            }
        }
        
        protected function checkMonthValidity(month:int):void
        {
            checkMonthAndDayCompatibility(userSuppliedDay, month, getDay());
        }
        
        protected function isLeapYear(year:int):Boolean
        {
            return  year % 400 === 0 || (year % 100 !== 0 && year % 4 === 0);
        }
    }
}
