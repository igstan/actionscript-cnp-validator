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
        public function generateForMale():void
        {
            cnpGenerator.male();
            
            Assert.assertEquals("1", cnpGenerator.generateCnp().charAt(0));
        }
        
        [Test]
        public function generateForFemale():void
        {
            cnpGenerator.female();
            
            Assert.assertEquals("2", cnpGenerator.generateCnp().charAt(0));
        }
        
        [Test]
        public function bornIn89():void
        {
            cnpGenerator.year(1989);
            
            Assert.assertEquals("89", cnpGenerator.generateCnp().substring(1, 3));
        }
        
        [Test]
        public function bornInFebruary():void
        {
            cnpGenerator.february();
            
            Assert.assertEquals("02", cnpGenerator.generateCnp().substring(3, 5));
        }
        
        [Test]
        public function bornInMay():void
        {
            cnpGenerator.may();
            
            Assert.assertEquals("05", cnpGenerator.generateCnp().substring(3, 5));
        }
        
        [Test]
        public function bornOn4th():void
        {
            cnpGenerator.day(4);
            
            Assert.assertEquals("04", cnpGenerator.generateCnp().substring(5, 7));
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
        public function bornOn2009February29th():void
        {
            cnpGenerator.year(2009).february().day(39);
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
            
            var cnpGenerator:CnpGenerator = new CnpGenerator(randomMonthGenerator);
            var cnp:String = cnpGenerator.day(31).generateCnp();
            
            Assert.assertEquals("03", cnp.substring(3, 5));
        }
    }
}
