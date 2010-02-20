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
        [Test]
        public function generateForMale():void
        {
            var cnpGenerator:CnpGenerator = new CnpGenerator();
            cnpGenerator.male();
            
            Assert.assertEquals("1", cnpGenerator.generateCnp().charAt(0));
        }
        
        [Test]
        public function generateForFemale():void
        {
            var cnpGenerator:CnpGenerator = new CnpGenerator();
            cnpGenerator.female();
            
            Assert.assertEquals("2", cnpGenerator.generateCnp().charAt(0));
        }
        
        [Test]
        public function bornIn89():void
        {
            var cnpGenerator:CnpGenerator = new CnpGenerator();
            cnpGenerator.birthYear(1989);
            
            Assert.assertEquals("89", cnpGenerator.generateCnp().substring(1, 3));
        }
        
        [Test]
        public function bornInFebruary():void
        {
            var cnpGenerator:CnpGenerator = new CnpGenerator();
            cnpGenerator.february();
            
            Assert.assertEquals("02", cnpGenerator.generateCnp().substring(3, 5));
        }
        
        [Test]
        public function bornInMay():void
        {
            var cnpGenerator:CnpGenerator = new CnpGenerator();
            cnpGenerator.may();
            
            Assert.assertEquals("05", cnpGenerator.generateCnp().substring(3, 5));
        }
        
        [Test]
        public function bornOn4th():void
        {
            var cnpGenerator:CnpGenerator = new CnpGenerator();
            cnpGenerator.day(4);
            
            Assert.assertEquals("04", cnpGenerator.generateCnp().substring(5, 7));
        }
        
        [Test(expects="ArgumentError")]
        public function bornOn32nd():void
        {
            var cnpGenerator:CnpGenerator = new CnpGenerator();
            cnpGenerator.day(32);
        }
        
        [Test(expects="ArgumentError")]
        public function bornOnZeroDay():void
        {
            var cnpGenerator:CnpGenerator = new CnpGenerator();
            cnpGenerator.day(0);
        }
        
        [Test(expects="ArgumentError")]
        public function bornOnFebruary31st():void
        {
            var cnpGenerator:CnpGenerator = new CnpGenerator();
            cnpGenerator.february().day(31);
        }
        
        [Test(expects="ArgumentError")]
        public function bornOn2009February29th():void
        {
            var cnpGenerator:CnpGenerator = new CnpGenerator();
            cnpGenerator.birthYear(2009).february().day(39);
        }
    }
}
