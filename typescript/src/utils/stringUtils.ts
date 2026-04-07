export class StringUtils {
    static reverse(str: string): string {
        return str.split('').reverse().join('');
    }

    static isPalindrome(str: string): boolean {
        const cleaned = str.toLowerCase().replace(/[^a-z0-9]/g, '');
        return cleaned === this.reverse(cleaned);
    }

    static countWords(str: string): number {
        return str.trim().split(/\s+/).length;
    }

    static countChars(str: string, includeSpaces: boolean = true): number {
        return includeSpaces ? str.length : str.replace(/\s/g, '').length;
    }

    static removeWhitespace(str: string): string {
        return str.replace(/\s+/g, '');
    }

    static contains(str: string, search: string, caseSensitive: boolean = true): boolean {
        return caseSensitive 
            ? str.includes(search) 
            : str.toLowerCase().includes(search.toLowerCase());
    }

    static startsWith(str: string, prefix: string, caseSensitive: boolean = true): boolean {
        return caseSensitive
            ? str.startsWith(prefix)
            : str.toLowerCase().startsWith(prefix.toLowerCase());
    }

    static endsWith(str: string, suffix: string, caseSensitive: boolean = true): boolean {
        return caseSensitive
            ? str.endsWith(suffix)
            : str.toLowerCase().endsWith(suffix.toLowerCase());
    }

    static extractNumbers(str: string): number[] {
        const matches = str.match(/-?\d+\.?\d*/g);
        return matches ? matches.map(n => parseFloat(n)) : [];
    }

    static extractEmails(str: string): string[] {
        const emailRegex = /[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}/g;
        const matches = str.match(emailRegex);
        return matches || [];
    }

    static extractUrls(str: string): string[] {
        const urlRegex = /https?:\/\/[^\s]+/g;
        const matches = str.match(urlRegex);
        return matches || [];
    }

    static toBase64(str: string): string {
        return Buffer.from(str).toString('base64');
    }

    static fromBase64(str: string): string {
        return Buffer.from(str, 'base64').toString('utf-8');
    }

    static hashCode(str: string): number {
        let hash = 0;
        for (let i = 0; i < str.length; i++) {
            const char = str.charCodeAt(i);
            hash = ((hash << 5) - hash) + char;
            hash = hash & hash;
        }
        return hash;
    }

    static levenshteinDistance(str1: string, str2: string): number {
        const m = str1.length;
        const n = str2.length;
        
        if (m === 0) return n;
        if (n === 0) return m;
        
        const dp: number[][] = Array(m + 1).fill(null).map(() => Array(n + 1).fill(0));
        
        for (let i = 0; i <= m; i++) dp[i][0] = i;
        for (let j = 0; j <= n; j++) dp[0][j] = j;
        
        for (let i = 1; i <= m; i++) {
            for (let j = 1; j <= n; j++) {
                const cost = str1[i - 1] === str2[j - 1] ? 0 : 1;
                dp[i][j] = Math.min(
                    dp[i - 1][j] + 1,
                    dp[i][j - 1] + 1,
                    dp[i - 1][j - 1] + cost
                );
            }
        }
        
        return dp[m][n];
    }

    static similarity(str1: string, str2: string): number {
        const maxLen = Math.max(str1.length, str2.length);
        if (maxLen === 0) return 1;
        const distance = this.levenshteinDistance(str1, str2);
        return 1 - distance / maxLen;
    }

    static truncateMiddle(str: string, maxLength: number, separator: string = '...'): string {
        if (str.length <= maxLength) return str;
        const charsToShow = maxLength - separator.length;
        const frontChars = Math.ceil(charsToShow / 2);
        const backChars = Math.floor(charsToShow / 2);
        return str.substr(0, frontChars) + separator + str.substr(str.length - backChars);
    }

    static parseQueryString(queryString: string): any {
        const params: any = {};
        const pairs = queryString.replace(/^\?/, '').split('&');
        
        for (const pair of pairs) {
            if (pair) {
                const [key, value] = pair.split('=');
                params[decodeURIComponent(key)] = decodeURIComponent(value || '');
            }
        }
        
        return params;
    }

    static toQueryString(params: any): string {
        const pairs: string[] = [];
        
        for (const key in params) {
            if (params.hasOwnProperty(key) && params[key] !== undefined && params[key] !== null) {
                pairs.push(`${encodeURIComponent(key)}=${encodeURIComponent(params[key])}`);
            }
        }
        
        return pairs.length > 0 ? '?' + pairs.join('&') : '';
    }
}
