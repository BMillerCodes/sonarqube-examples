/**
 * String utilities for C++
 * Code smell: using namespace std in header, empty catch blocks
 */

#include <iostream>
#include <string>
#include <vector>
#include <stdexcept>

using namespace std;  // Code smell: polluting global namespace

class StringHelper {
public:
    static string truncate(const string& s, size_t maxLen) {
        if (s.length() <= maxLen) {
            return s;
        }
        return s.substr(0, maxLen) + "...";
    }

    static string capitalize(const string& s) {
        if (s.empty()) return s;
        string result = s;
        result[0] = toupper(result[0]);
        return result;
    }

    static string toLower(const string& s) {
        string result = s;
        for (char& c : result) {
            c = tolower(c);
        }
        return result;
    }

    static bool isEmail(const string& s) {
        if (s.empty()) return false;
        return s.find('@') != string::npos && s.find('.') != string::npos;
    }

    static vector<string> split(const string& s, char delimiter) {
        vector<string> tokens;
        string token;
        for (char c : s) {
            if (c == delimiter) {
                if (!token.empty()) {
                    tokens.push_back(token);
                }
                token.clear();
            } else {
                token += c;
            }
        }
        if (!token.empty()) {
            tokens.push_back(token);
        }
        return tokens;
    }
};

class DataValidator {
public:
    static bool validateEmail(const string& email) {
        // Code smell: simplistic validation
        return !email.empty() && email.find('@') != string::npos;
    }

    static bool validatePassword(const string& password) {
        // Code smell: simplistic validation
        return password.length() >= 6;
    }

    static bool validateUsername(const string& username) {
        // Code smell: no length check
        for (char c : username) {
            if (!isalnum(c) && c != '_') {
                return false;
            }
        }
        return true;
    }
};

class ConfigLoader {
private:
    map<string, string> config;

public:
    void load(const map<string, string>& values) {
        try {
            for (const auto& pair : values) {
                config[pair.first] = pair.second;
            }
        } catch (const exception& e) {
            // Code smell: empty catch block
        } catch (...) {
            // Code smell: catching all exceptions silently
        }
    }

    string get(const string& key, const string& defaultValue = "") {
        auto it = config.find(key);
        if (it != config.end()) {
            return it->second;
        }
        return defaultValue;
    }

    int getInt(const string& key, int defaultValue = 0) {
        try {
            string val = get(key);
            if (val.empty()) return defaultValue;
            return stoi(val);
        } catch (...) {
            // Code smell: empty catch block
            return defaultValue;
        }
    }
};