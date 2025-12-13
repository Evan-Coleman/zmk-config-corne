# Feature: Leader Key Sequences

## What Is It?

A Vim-inspired input method where you tap a "leader" key, then type a sequence of keys to trigger an action. Like a command palette on your keyboard.

```
Leader → g → c → Triggers "git commit" macro
Leader → e → m → Types your email address
Leader → / → / → Types "// " (comment prefix)
```

## Why Use It?

1. **Namespace expansion** - Turn 26 keys into 26x26 = 676 possible commands
2. **Memorable shortcuts** - `g-c` for git commit, `e-m` for email
3. **Reduce layers** - Put rare actions behind leader sequences instead of layers
4. **Macros without dedicated keys** - Text expansions, snippets, commands

## When to Use It

**Good for:**
- Infrequent but important actions (git commands, email address)
- Text snippets you type regularly
- Complex key sequences (Ctrl+Shift+Alt+something)
- Actions you'd forget if they were on a layer

**Not ideal for:**
- Frequent single-character input (too slow)
- Actions needed while typing flow (interrupts)
- Time-critical shortcuts

---

## How It Works

```
1. Tap Leader key → Keyboard enters "listening" mode
2. Type sequence → Each key is captured
3. Match found → Execute bound action
4. No match → Timeout or cancel
```

Timeout typically 500-1000ms between keys.

---

## Implementation for Your Setup

### Required Module

You have `zmk-leader-key` in your `west.yml`:
```yaml
- name: zmk-leader-key
  path: modules/zmk/leader-key
```

### Create leader.dtsi

```c
// config/leader.dtsi
// Leader key sequences for common actions

/ {
    macros {
        // Email address
        email_addr: email_address {
            compatible = "zmk,behavior-macro";
            label = "EMAIL_ADDR";
            #binding-cells = <0>;
            bindings = <&kp Y &kp O &kp U &kp R &kp E &kp M &kp A &kp I &kp L
                        &kp AT
                        &kp E &kp X &kp A &kp M &kp P &kp L &kp E &kp DOT &kp C &kp O &kp M>;
        };

        // Arrow function
        arrow_fn: arrow_function {
            compatible = "zmk,behavior-macro";
            label = "ARROW_FN";
            #binding-cells = <0>;
            bindings = <&kp EQUAL &kp GT &kp SPACE>;  // =>
        };

        // Comment line
        comment_line: comment_line {
            compatible = "zmk,behavior-macro";
            label = "COMMENT_LINE";
            #binding-cells = <0>;
            bindings = <&kp FSLH &kp FSLH &kp SPACE>;  // //
        };

        // Console log
        console_log: console_log {
            compatible = "zmk,behavior-macro";
            label = "CONSOLE_LOG";
            #binding-cells = <0>;
            bindings = <&kp C &kp O &kp N &kp S &kp O &kp L &kp E &kp DOT
                        &kp L &kp O &kp G &kp LPAR &kp RPAR &kp LEFT>;
        };

        // Git status
        git_status: git_status {
            compatible = "zmk,behavior-macro";
            label = "GIT_STATUS";
            #binding-cells = <0>;
            bindings = <&kp G &kp I &kp T &kp SPACE &kp S &kp T &kp A &kp T &kp U &kp S>;
        };

        // Git commit
        git_commit: git_commit {
            compatible = "zmk,behavior-macro";
            label = "GIT_COMMIT";
            #binding-cells = <0>;
            bindings = <&kp G &kp I &kp T &kp SPACE &kp C &kp O &kp M &kp M &kp I &kp T
                        &kp SPACE &kp MINUS &kp M &kp SPACE &kp DQT>;
        };

        // Git push
        git_push: git_push {
            compatible = "zmk,behavior-macro";
            label = "GIT_PUSH";
            #binding-cells = <0>;
            bindings = <&kp G &kp I &kp T &kp SPACE &kp P &kp U &kp S &kp H>;
        };
    };

    behaviors {
        leader: leader_key {
            compatible = "zmk,behavior-leader-key";
            label = "LEADER";
            #binding-cells = <0>;
            timeout-ms = <1000>;  // 1 second between keys
            bindings =
                // Email: leader → e → m
                <&email_addr E M>,
                // Arrow function: leader → = → >
                <&arrow_fn EQUAL GT>,
                // Comment: leader → / → /
                <&comment_line FSLH FSLH>,
                // Console log: leader → c → l
                <&console_log C L>,
                // Git commands: leader → g → (s/c/p)
                <&git_status G S>,
                <&git_commit G C>,
                <&git_push G P>;
        };
    };
};
```

### Include in corne.keymap

```c
#include "leader.dtsi"
```

### Place Leader Key

Options for leader key placement:

**Option 1: Combo activation**
```c
combos {
    combo_leader {
        timeout-ms = <50>;
        require-prior-idle-ms = <150>;
        key-positions = <36 37>;  // TAB + LWR (left thumbs)
        bindings = <&leader>;
        layers = <0>;
    };
};
```

**Option 2: On a layer**
```c
// In Raise layer, replace an unused key
&leader  // Position it where it's easy to reach
```

**Option 3: Dedicated key**
Your outer column has room - consider position 0 (currently GRAVE):
```c
&leader  &kp Q  &kp W  &kp E  &kp R  &kp T  ...
```

---

## Sequence Design Principles

### Use Mnemonics
```
g → s = Git Status
g → c = Git Commit
g → p = Git Push
e → m = Email
/ → / = Comment
```

### Group by Category
```
g → ... = Git commands
e → ... = Email/text snippets
c → ... = Code snippets
s → ... = System commands
```

### Short Sequences for Common Actions
```
Leader + 2 keys = Most common
Leader + 3 keys = Less common
Leader + 4+ keys = Rarely used
```

---

## More Sequence Ideas

### Text Snippets
```c
// Thank you
<&macro_thanks T H>  // types "Thank you for your "

// Best regards
<&macro_regards B R>  // types "Best regards,\n[Your Name]"

// Shrug emoji (if unicode works)
<&macro_shrug S H>  // types ¯\_(ツ)_/¯
```

### Code Snippets
```c
// Function
<&macro_func F N>  // types "function () {}" and positions cursor

// If statement
<&macro_if I F>  // types "if () {}" and positions cursor

// For loop
<&macro_for F O>  // types "for (let i = 0; i < ; i++) {}"
```

### Navigation/System
```c
// Screenshot
<&kp LG(LS(N4)) S S>  // macOS screenshot

// Lock screen
<&kp LG(LC(Q)) L K>  // macOS lock

// New terminal tab
<&kp LG(T) T T>
```

---

## Comparison with Other Methods

| Method | Pros | Cons |
|--------|------|------|
| **Leader** | Many sequences, memorable | Extra keystrokes, timeout |
| **Layers** | Fast access, visual | Limited keys, layer management |
| **Combos** | Instant, one action | Limited to 2-3 keys, conflicts |
| **Macros (dedicated key)** | One keystroke | Uses a key permanently |

---

## Visual Reference Card

Make yourself a cheat sheet:

```
LEADER SEQUENCES
================

[E]mail
  └─[M] → your@email.com

[G]it
  ├─[S] → git status
  ├─[C] → git commit -m "
  └─[P] → git push

[C]ode
  └─[L] → console.log()

[/]Comment
  └─[/] → //

[=]Arrow
  └─[>] → =>
```

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Sequence doesn't trigger | Check key order, verify macro syntax |
| Timeout too fast | Increase `timeout-ms` |
| Wrong characters typed | Macro uses keycodes not characters (US layout assumed) |
| Leader key interferes | Use combo to avoid dedicated key |

---

## Is It Worth It?

**Yes, if:**
- You type the same snippets repeatedly
- You want git commands without reaching for terminal
- You like Vim-style command input
- You want to reduce layer complexity

**Maybe not, if:**
- You prefer visual layer indicators
- Your snippets are too long (just type them)
- You're not comfortable memorizing sequences
