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
    
    import ro.igstan.util.CnpValidator;
    
    
    public class CnpValidatorTest
    {
        private var cnpValidator:CnpValidator;
        
        [Before]
        public function setUp():void
        {
            this.cnpValidator = new CnpValidator();
        }
        
        [Test]
        public function rejectsCNPsNotHaving13DigitsOnly():void
        {
            Assert.assertFalse(cnpValidator.validates(""));
        }
        
        [Test]
        public function rejectsCNPsStartingWithDigit0():void
        {
            Assert.assertFalse(cnpValidator.validates("0123456789123"));
        }
        
        [Test]
        public function rejectsCNPsStartingWithDigit7():void
        {
            Assert.assertFalse(cnpValidator.validates("7123456789123"));
        }
        
        [Test]
        public function rejectsCNPsStartingWithDigit8():void
        {
            Assert.assertFalse(cnpValidator.validates("8123456789123"));
        }
        
        [Test]
        public function rejectsCNPsNotContainingAValidDate1():void
        {
            Assert.assertFalse(cnpValidator.validates("1000000789123"));
        }
        
        [Test]
        public function rejectsCNPsNotContainingAValidDate2():void
        {
            // February 31st, '84
            Assert.assertFalse(cnpValidator.validates("1840231789123"));
        }
        
        [Test]
        public function rejectsCNPsNotContainingAValidDate3():void
        {
            // April 31st, '84
            Assert.assertFalse(cnpValidator.validates("1840431789123"));
        }
        
        [Test]
        public function validatesControlDigit():void
        {
            // Original CNP was: 1850401241933.
            // The last digit (the control digit) differs.
            Assert.assertFalse(cnpValidator.validates("1850401241932"));
        }
        
        [Test]
        public function validatesCNP():void
        {
            Assert.assertTrue(cnpValidator.validates("1850401241933"));
        }
    }
}
