export class Validator {
    static isEmail(email: string): boolean {
        if (!email) return false;
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }

    static isUrl(url: string): boolean {
        if (!url) return false;
        try {
            new URL(url);
            return true;
        } catch {
            return false;
        }
    }

    static isPhone(phone: string): boolean {
        if (!phone) return false;
        const phoneRegex = /^\+?[\d\s-()]+$/;
        return phoneRegex.test(phone) && phone.replace(/\D/g, '').length >= 10;
    }

    static isPostalCode(postalCode: string, countryCode?: string): boolean {
        if (!postalCode) return false;
        
        const patterns: any = {
            US: /^\d{5}(-\d{4})?$/,
            UK: /^[A-Z]{1,2}\d{1,2}[A-Z]?\s?\d[A-Z]{2}$/i,
            CA: /^[A-Z]\d[A-Z]\s?\d[A-Z]\d$/i,
            DE: /^\d{5}$/,
            FR: /^\d{5}$/,
            JP: /^\d{3}-?\d{4}$/,
        };
        
        if (countryCode && patterns[countryCode]) {
            return patterns[countryCode].test(postalCode);
        }
        
        return postalCode.length >= 3 && postalCode.length <= 10;
    }

    static isCreditCard(cardNumber: string): boolean {
        if (!cardNumber) return false;
        
        const cleaned = cardNumber.replace(/\s|-/g, '');
        
        if (!/^\d{13,19}$/.test(cleaned)) return false;
        
        let sum = 0;
        let isEven = false;
        
        for (let i = cleaned.length - 1; i >= 0; i--) {
            let digit = parseInt(cleaned[i], 10);
            
            if (isEven) {
                digit *= 2;
                if (digit > 9) {
                    digit -= 9;
                }
            }
            
            sum += digit;
            isEven = !isEven;
        }
        
        return sum % 10 === 0;
    }

    static isPasswordStrong(password: string): boolean {
        if (!password || password.length < 8) return false;
        
        const hasUpperCase = /[A-Z]/.test(password);
        const hasLowerCase = /[a-z]/.test(password);
        const hasNumber = /\d/.test(password);
        const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(password);
        
        return hasUpperCase && hasLowerCase && hasNumber && hasSpecialChar;
    }

    static sanitizeString(input: string): string {
        if (!input) return '';
        return input.replace(/[<>\"'&]/g, (char) => {
            const entities: any = {
                '<': '&lt;',
                '>': '&gt;',
                '"': '&quot;',
                "'": '&#x27;',
                '&': '&amp;'
            };
            return entities[char];
        });
    }

    static validateObject(obj: any, schema: any): boolean {
        if (!obj || !schema) return false;
        
        for (const key in schema) {
            const rules = schema[key];
            
            if (rules.required && (obj[key] === undefined || obj[key] === null)) {
                return false;
            }
            
            if (obj[key] !== undefined && obj[key] !== null) {
                if (rules.type && typeof obj[key] !== rules.type) {
                    return false;
                }
                
                if (rules.min !== undefined && obj[key] < rules.min) {
                    return false;
                }
                
                if (rules.max !== undefined && obj[key] > rules.max) {
                    return false;
                }
                
                if (rules.pattern && !rules.pattern.test(obj[key])) {
                    return false;
                }
                
                if (rules.enum && !rules.enum.includes(obj[key])) {
                    return false;
                }
            }
        }
        
        return true;
    }

    static isDateRangeValid(start: any, end: any): boolean {
        const startDate = new Date(start);
        const endDate = new Date(end);
        
        return startDate <= endDate;
    }

    static isAgeValid(birthDate: any, minAge: number, maxAge: number): boolean {
        const birth = new Date(birthDate);
        const today = new Date();
        
        let age = today.getFullYear() - birth.getFullYear();
        const monthDiff = today.getMonth() - birth.getMonth();
        
        if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birth.getDate())) {
            age--;
        }
        
        return age >= minAge && age <= maxAge;
    }

    static validateIPAddress(ip: string): boolean {
        if (!ip) return false;
        
        const ipv4Regex = /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/;
        const ipv6Regex = /^(?:[0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$/;
        
        return ipv4Regex.test(ip) || ipv6Regex.test(ip);
    }

    static isHexColor(color: string): boolean {
        if (!color) return false;
        return /^#?([0-9A-F]{3}|[0-9A-F]{6})$/i.test(color);
    }

    static isJSON(str: string): boolean {
        if (!str) return false;
        try {
            JSON.parse(str);
            return true;
        } catch {
            return false;
        }
    }

    static validateFileSize(size: number, maxSizeMB: number): boolean {
        const maxBytes = maxSizeMB * 1024 * 1024;
        return size > 0 && size <= maxBytes;
    }

    static validateFileType(filename: string, allowedTypes: string[]): boolean {
        if (!filename || !allowedTypes || allowedTypes.length === 0) return false;
        
        const extension = filename.split('.').pop()?.toLowerCase();
        return extension !== undefined && allowedTypes.includes(extension);
    }

    static normalizePhone(phone: string): string {
        if (!phone) return '';
        return phone.replace(/\D/g, '');
    }

    static normalizeEmail(email: string): string {
        if (!email) return '';
        return email.toLowerCase().trim();
    }
}
