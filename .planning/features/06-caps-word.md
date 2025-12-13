# Feature: Caps Word

## What Is It?

A smarter Caps Lock that automatically deactivates after you finish typing a "word." Perfect for:
- `CONSTANT_NAMES`
- `SCREAMING_SNAKE_CASE`
- Short `ACRONYMS`

## Why Use It?

### The Problem with Caps Lock
1. You forget to turn it off → "HELLO i FORGOT"
2. You have to reach for a dedicated key
3. It's all-or-nothing

### The Problem with Holding Shift
1. Awkward for long words
2. Easy to release early
3. Uncomfortable with HRM

### The Solution: Caps Word
- Activate with a combo or double-tap
- Type your capitalized word
- Press space or punctuation → Automatically deactivates
- Underscore, minus, and backspace DON'T deactivate (for SNAKE_CASE)

---

## How It Works

```
Activate Caps Word → "CAPS_WORD" active
├── Type A-Z → Outputs uppercase
├── Type 0-9 → Outputs numbers (doesn't deactivate)
├── Type _ or - → Stays active (for SNAKE_CASE)
├── Type Backspace → Stays active (fix typos)
└── Type Space or punctuation → DEACTIVATES
```

---

## Your Current Setup

You have `caps_ptsc` on position 11:
```c
caps_ptsc: caps_ptsc {
    compatible = "zmk,behavior-tap-dance";
    label = "CAPS_PTSC";
    #binding-cells = <0>;
    bindings = <&kp CAPS>, <&kp PRINTSCREEN>;
};
```

This gives you:
- Tap → Traditional Caps Lock
- Double-tap → Print Screen

**Problem**: Traditional Caps Lock is less useful than Caps Word.

---

## Implementation for Your Setup

### Option 1: Replace caps_ptsc

Update your existing behavior:

```c
caps_word_ptsc: caps_word_ptsc {
    compatible = "zmk,behavior-tap-dance";
    label = "CAPS_WORD_PTSC";
    #binding-cells = <0>;
    bindings = <&caps_word>, <&kp PRINTSCREEN>;
};
```

Now:
- Tap → Caps Word (smart)
- Double-tap → Print Screen

Update keymap:
```c
&kp GRAVE  &kp Q  &kp W  &kp E  &kp R  &kp T    &kp Y  &kp U  &kp I  &kp O  &kp SEMI  &caps_word_ptsc
```

### Option 2: Combo Activation

Keep your existing key, add a combo for Caps Word:

```c
combos {
    combo_caps_word {
        timeout-ms = <50>;
        require-prior-idle-ms = <100>;
        key-positions = <16 19>;  // F + J (home position index fingers)
        bindings = <&caps_word>;
        layers = <0>;
    };
};
```

**Why F+J?** Both index fingers on home position - easy to hit together intentionally, rare to hit accidentally.

### Option 3: Smart Shift Double-Tap

If you implement the Smart Shift feature:
```c
// Double-tap Smart Shift → Caps Word
// (Already covered in 02-smart-shift-repeat.md)
```

---

## Configure Continue List

By default, Caps Word deactivates on anything except A-Z, 0-9.

Add these to keep typing in SNAKE_CASE:

```c
&caps_word {
    continue-list = <UNDERSCORE MINUS BACKSPACE DELETE>;
};
```

Place this in the root of your devicetree (outside any other block):

```c
/ {
    // Your combos, behaviors, etc.
};

// Configure caps_word behavior
&caps_word {
    continue-list = <UNDERSCORE MINUS BACKSPACE DELETE>;
};
```

---

## Usage Examples

### Programming Constants
```
Activate → type: my_constant_name
Output: MY_CONSTANT_NAME
Deactivates when you press space or semicolon
```

### Acronyms
```
Activate → type: api
Output: API
Deactivates when you continue typing lowercase
```

### Fixing Typos
```
Activate → type: COSTANT
Backspace → COSTAN
Type: NT
Output: CONSTANT (backspace didn't deactivate!)
```

---

## Caps Word vs Other Methods

| Method | Best For | Drawback |
|--------|----------|----------|
| **Caps Word** | Single words, constants | Deactivates on space |
| **Caps Lock** | Multiple capitalized words | Must manually disable |
| **Hold Shift** | 1-2 characters | Uncomfortable for long words |
| **Sticky Shift** | Single characters | One character only |

---

## Visual Indicator

ZMK doesn't have a built-in Caps Word LED indicator, but if you have a nice!view display:
- The word "CAPS" or similar can be shown
- Check ZMK Studio for display customization

Without indicator:
- You'll know Caps Word is active when letters come out UPPERCASE
- Gets intuitive quickly

---

## Common Workflows

### 1. Environment Variable
```
Type: export →
Activate Caps Word →
Type: my_api_key →
Output: export MY_API_KEY
Press = → deactivates
Continue: ="secret"
```

### 2. SQL Keywords
```
Activate → type: select * from users where
Output: SELECT * FROM USERS WHERE
(Each word deactivates caps, but you can reactivate)
```

Wait, that won't work since space deactivates. For SQL:
```
Activate → type: select →
Output: SELECT
(deactivates on space, reactivate for each keyword)
```

Or use traditional Caps Lock for multi-word uppercase.

### 3. Code Constants
```
Activate → type: max_retry_count →
Output: MAX_RETRY_COUNT
Press ; or = → deactivates, continue typing value
```

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Underscore deactivates | Add `UNDERSCORE` to continue-list |
| Minus deactivates | Add `MINUS` to continue-list |
| Need multi-word caps | Use traditional Caps Lock instead |
| Accidentally activated | Make combo harder (wider key spread) |

---

## Suggested Setup

For your 6-column Corne:

```c
// 1. Configure caps_word
&caps_word {
    continue-list = <UNDERSCORE MINUS BACKSPACE DELETE>;
};

// 2. Add combo (in combos section)
combo_caps_word {
    timeout-ms = <50>;
    require-prior-idle-ms = <100>;
    key-positions = <16 19>;  // F + J
    bindings = <&caps_word>;
    layers = <0>;
};

// 3. Optionally update your caps_ptsc
caps_word_ptsc: caps_word_ptsc {
    compatible = "zmk,behavior-tap-dance";
    label = "CAPS_WORD_PTSC";
    #binding-cells = <0>;
    bindings = <&caps_word>, <&kp PRINTSCREEN>;
};
```

This gives you:
- F+J combo → Caps Word (fastest)
- Top-right key tap → Caps Word
- Top-right key double-tap → Print Screen

---

## Is It Worth It?

**Absolutely, if:**
- You write code with CONSTANT_NAMES
- You type ENVIRONMENT_VARIABLES
- You hate hunting for Caps Lock to turn it off

**Still useful, even if:**
- You don't code much (still beats Caps Lock for occasional use)

**Basically no downside** - It's a strict improvement over Caps Lock for 90% of use cases.
