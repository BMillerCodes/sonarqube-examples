export class DateUtils {
    static addDays(date: Date, days: number): Date {
        const result = new Date(date);
        result.setDate(result.getDate() + days);
        return result;
    }

    static subtractDays(date: Date, days: number): Date {
        return this.addDays(date, -days);
    }

    static addMonths(date: Date, months: number): Date {
        const result = new Date(date);
        result.setMonth(result.getMonth() + months);
        return result;
    }

    static subtractMonths(date: Date, months: number): Date {
        return this.addMonths(date, -months);
    }

    static addYears(date: Date, years: number): Date {
        const result = new Date(date);
        result.setFullYear(result.getFullYear() + years);
        return result;
    }

    static isWeekend(date: Date): boolean {
        const day = date.getDay();
        return day === 0 || day === 6;
    }

    static isWeekday(date: Date): boolean {
        return !this.isWeekend(date);
    }

    static getDaysInMonth(year: number, month: number): number {
        return new Date(year, month + 1, 0).getDate();
    }

    static getWeeksInMonth(year: number, month: number): number {
        const firstDay = new Date(year, month, 1);
        const lastDay = new Date(year, month + 1, 0);
        const daysInMonth = lastDay.getDate();
        const startingDayOfWeek = firstDay.getDay();
        
        return Math.ceil((daysInMonth + startingDayOfWeek) / 7);
    }

    static isSameDay(date1: Date, date2: Date): boolean {
        return date1.getFullYear() === date2.getFullYear() &&
               date1.getMonth() === date2.getMonth() &&
               date1.getDate() === date2.getDate();
    }

    static isSameMonth(date1: Date, date2: Date): boolean {
        return date1.getFullYear() === date2.getFullYear() &&
               date1.getMonth() === date2.getMonth();
    }

    static getDaysBetween(start: Date, end: Date): number {
        const oneDay = 24 * 60 * 60 * 1000;
        return Math.round(Math.abs((end.getTime() - start.getTime()) / oneDay));
    }

    static getMonthsBetween(start: Date, end: Date): number {
        return (end.getFullYear() - start.getFullYear()) * 12 + (end.getMonth() - start.getMonth());
    }

    static getYearsBetween(start: Date, end: Date): number {
        return end.getFullYear() - start.getFullYear();
    }

    static startOfDay(date: Date): Date {
        const result = new Date(date);
        result.setHours(0, 0, 0, 0);
        return result;
    }

    static endOfDay(date: Date): Date {
        const result = new Date(date);
        result.setHours(23, 59, 59, 999);
        return result;
    }

    static startOfWeek(date: Date): Date {
        const result = new Date(date);
        const day = result.getDay();
        result.setDate(result.getDate() - day);
        result.setHours(0, 0, 0, 0);
        return result;
    }

    static endOfWeek(date: Date): Date {
        const result = new Date(date);
        const day = result.getDay();
        result.setDate(result.getDate() + (6 - day));
        result.setHours(23, 59, 59, 999);
        return result;
    }

    static startOfMonth(date: Date): Date {
        return new Date(date.getFullYear(), date.getMonth(), 1);
    }

    static endOfMonth(date: Date): Date {
        return new Date(date.getFullYear(), date.getMonth() + 1, 0, 23, 59, 59, 999);
    }

    static startOfYear(date: Date): Date {
        return new Date(date.getFullYear(), 0, 1);
    }

    static endOfYear(date: Date): Date {
        return new Date(date.getFullYear(), 11, 31, 23, 59, 59, 999);
    }

    static isLeapYear(year: number): boolean {
        return (year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0);
    }

    static getQuarter(date: Date): number {
        return Math.floor(date.getMonth() / 3) + 1;
    }

    static getDaysUntil(date: Date): number {
        const today = this.startOfDay(new Date());
        const target = this.startOfDay(date);
        return Math.ceil((target.getTime() - today.getTime()) / (1000 * 60 * 60 * 24));
    }

    static getAge(birthDate: Date): number {
        const today = new Date();
        let age = today.getFullYear() - birthDate.getFullYear();
        const monthDiff = today.getMonth() - birthDate.getMonth();
        
        if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
            age--;
        }
        
        return age;
    }

    static formatRelativeTime(date: Date): string {
        const now = new Date();
        const diffMs = date.getTime() - now.getTime();
        const diffSecs = Math.round(diffMs / 1000);
        const diffMins = Math.round(diffSecs / 60);
        const diffHours = Math.round(diffMins / 60);
        const diffDays = Math.round(diffHours / 24);

        if (Math.abs(diffSecs) < 60) {
            return diffSecs === 0 ? 'just now' : (diffSecs > 0 ? 'in a few seconds' : 'a few seconds ago');
        }
        
        if (Math.abs(diffMins) < 60) {
            return diffMins === 1 ? '1 minute ago' : (diffMins > 0 ? `in ${diffMins} minutes` : `${Math.abs(diffMins)} minutes ago`);
        }
        
        if (Math.abs(diffHours) < 24) {
            return diffHours === 1 ? '1 hour ago' : (diffHours > 0 ? `in ${diffHours} hours` : `${Math.abs(diffHours)} hours ago`);
        }
        
        if (Math.abs(diffDays) < 30) {
            return diffDays === 1 ? 'yesterday' : (diffDays > 0 ? `in ${diffDays} days` : `${Math.abs(diffDays)} days ago`);
        }
        
        return date.toLocaleDateString();
    }
}
