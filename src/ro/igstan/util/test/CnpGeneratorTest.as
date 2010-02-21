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

package ro.igstan.util.test
{
    import org.flexunit.Assert;
    
    import ro.igstan.util.CnpGenerator;
    
    
    public class CnpGeneratorTest
    {
        private var cnpGenerator:CnpGenerator;
        
        [Before]
        public function setUp():void
        {
            cnpGenerator = new CnpGenerator();
        }
        
        [Test]
        public function bornIn89():void
        {
            var cnp:String = cnpGenerator.year(1989).generateCnp();
            assertBirthYear("89", cnp);
        }
        
        [Test]
        public function bornInFebruary():void
        {
            var cnp:String = cnpGenerator.february().generateCnp();
            assertBirthMonth("02", cnp);
        }
        
        [Test]
        public function bornInMay():void
        {
            var cnp:String = cnpGenerator.may().generateCnp();
            assertBirthMonth("05", cnp);
        }
        
        [Test]
        public function bornOn4th():void
        {
            var cnp:String = cnpGenerator.day(4).generateCnp();
            assertBirthDay("04", cnp);
        }
        
        [Test(expects="ArgumentError")]
        public function bornOn32nd():void
        {
            cnpGenerator.day(32);
        }
        
        [Test(expects="ArgumentError")]
        public function bornOnZeroDay():void
        {
            cnpGenerator.day(0);
        }
        
        [Test(expects="ArgumentError")]
        public function bornOnFebruary31st():void
        {
            cnpGenerator.february().day(31);
        }
        
        [Test(expects="ArgumentError")]
        public function bornOn31stOfFebruary():void
        {
            cnpGenerator.day(31).february();
        }
        
        [Test(expects="ArgumentError")]
        public function bornOnFebruary29thInANonLeapYear1():void
        {
            cnpGenerator.year(2009).february().day(29);
        }
        
        [Test(expects="ArgumentError")]
        public function bornOnFebruary29thInANonLeapYear2():void
        {
            cnpGenerator.year(2009).day(29).february();
        }
        
        [Test(expects="ArgumentError")]
        public function bornOn31stInAMonthWith30Days1():void
        {
            cnpGenerator.day(31).april();
        }
        
        [Test(expects="ArgumentError")]
        public function bornOn31stInAMonthWith30Days2():void
        {
            cnpGenerator.april().day(31);
        }
        
        [Test]
        public function settingDayOn31DoesNotUsesFebruary():void
        {
            var firstCall:Boolean = true;
            var randomMonthGenerator:Function = function():int {
                if (firstCall) {
                    firstCall = false;
                    return 2;
                } else {
                    return 3;
                }
            };
            
            var cnpGenerator:CnpGenerator = new CnpGenerator({
                monthGenerator: randomMonthGenerator
            });
            var cnp:String = cnpGenerator.day(31).generateCnp();
            
            assertBirthMonth("03", cnp);
        }
        
        [Test]
        public function settingDayOn30DoesNotUsesFebruary():void
        {
            var firstCall:Boolean = true;
            var randomMonthGenerator:Function = function():int {
                if (firstCall) {
                    firstCall = false;
                    return 2;
                } else {
                    return 3;
                }
            };
            
            var cnpGenerator:CnpGenerator = new CnpGenerator({
                monthGenerator: randomMonthGenerator
            });
            var cnp:String = cnpGenerator.day(30).generateCnp();
            
            assertBirthMonth("03", cnp);
        }
        
        [Test]
        public function settingDayOn29AndMonthOnFebruaryGeneratesLeapYear():void
        {
            var leapYear:int = 2008;
            var nonLeapYear:int = 2009;
            var firstCall:Boolean = true;
            var randomYearGenerator:Function = function():int {
                if (firstCall) {
                    firstCall = false;
                    return nonLeapYear;
                } else {
                    return leapYear;
                }
            };
            
            var cnpGenerator:CnpGenerator = new CnpGenerator({
                yearGenerator: randomYearGenerator
            });
            
            var cnp:String = cnpGenerator.february().day(29).generateCnp();
            
            assertBirthYear("08", cnp);
        }
        
        [Test]
        public function bornInPrahova():void
        {
            var cnp:String = cnpGenerator.regionPrahova().generateCnp();
            assertRegion("29", cnp);
        }
        
        [Test]
        public function bornInRandomRegion():void
        {
            var randomRegionGenerator:Function = function():String {
                return "13";
            };
            
            var cnpGenerator:CnpGenerator = new CnpGenerator({
                regionGenerator: randomRegionGenerator
            });
            
            var cnp:String = cnpGenerator.generateCnp();
            
            assertRegion("13", cnp);
        }
        
        [Test]
        public function maleBornBetween1900And1999HasGenderDigit1():void
        {
            var cnp:String = cnpGenerator.male().year(1980).generateCnp();
            assertGenderDigit("1", cnp);
        }
        
        [Test]
        public function femaleBornBetween1900And1999HasGenderDigit2():void
        {
            var cnp:String = cnpGenerator.female().year(1980).generateCnp();
            assertGenderDigit("2", cnp);
        }
        
        [Test]
        public function maleBornBetween1800And1899HasGenderDigit3():void
        {
            var cnp:String = cnpGenerator.male().year(1880).generateCnp();
            assertGenderDigit("3", cnp);
        }
        
        [Test]
        public function femaleBornBetween1800And1899HasGenderDigit4():void
        {
            var cnp:String = cnpGenerator.female().year(1880).generateCnp();
            assertGenderDigit("4", cnp);
        }
        
        [Test]
        public function maleBornBetween2000And2099HasGenderDigit5():void
        {
            var cnp:String = cnpGenerator.male().year(2080).generateCnp();
            assertGenderDigit("5", cnp);
        }
        
        [Test]
        public function femaleBornBetween2000And2099HasGenderDigit6():void
        {
            var cnp:String = cnpGenerator.female().year(2080).generateCnp();
            assertGenderDigit("6", cnp);
        }
        
        protected function assertBirthYear(expectedYear:String, cnp:String):void
        {
            Assert.assertEquals(expectedYear, cnp.substring(1, 3));
        }
        
        protected function assertBirthMonth(expectedMonth:String, cnp:String):void
        {
            Assert.assertEquals(expectedMonth, cnp.substring(3, 5));
        }
        
        protected function assertBirthDay(expectedDay:String, cnp:String):void
        {
            Assert.assertEquals(expectedDay, cnp.substring(5, 7));
        }
        
        protected function assertRegion(expectedRegion:String, cnp:String):void
        {
            Assert.assertEquals(expectedRegion, cnp.substring(7, 9));
        }
        
        protected function assertGenderDigit(genderDigit:String, cnp:String):void
        {
            Assert.assertEquals(genderDigit, cnp.charAt(0));
        }
    }
}
