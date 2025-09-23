To set up a configuration file for Doxygen for a C++ project, you’ll typically follow these steps:

---

### 🛠️ Step-by-Step: Create and Customize a Doxygen Config File

#### 1. **Generate the Default Config File**
Open a terminal in your project directory and run:
```bash
doxygen -g Doxyfile
```
This creates a file named `Doxyfile` with all the default settings.

---

#### 2. **Edit Key Settings in `Doxyfile`**
Open `Doxyfile` in your favorite editor and adjust the following:

| Setting | Description | Example |
|--------|-------------|--------|
| `PROJECT_NAME` | Name of your project | `"MyCppProject"` |
| `INPUT` | Source directories or files | `"src include"` |
| `FILE_PATTERNS` | File extensions to include | `"*.cpp *.h"` |
| `RECURSIVE` | Search subdirectories | `YES` |
| `OUTPUT_DIRECTORY` | Where to put generated docs | `"docs"` |
| `GENERATE_HTML` | Enable HTML output | `YES` |
| `GENERATE_LATEX` | Enable PDF output (optional) | `NO` |
| `EXTRACT_ALL` | Document everything, even without comments | `YES` |
| `EXTRACT_PRIVATE` | Include private members | `YES` (optional) |
| `EXCLUDE` | Files or folders to skip | `"test/"` (optional) |

---

#### 3. **Run Doxygen**
Once configured, generate the documentation:
```bash
doxygen Doxyfile
```
It will create a `docs/html` folder (or whatever you set in `OUTPUT_DIRECTORY`) with your documentation.

---

### 🧩 Optional Enhancements
- **Use Markdown in comments**: Set `MARKDOWN_SUPPORT = YES`
- **Graphical call graphs**: Set `HAVE_DOT = YES` and install Graphviz
- **Custom logo**: Set `PROJECT_LOGO = path/to/logo.png`

---



To visualize **function call graphs** in Doxygen—like seeing which functions are called inside `main()`—you’ll need to enable a few specific settings and have [Graphviz](https://graphviz.org/) installed. Here's how to do it:

---

### 🧠 Step-by-Step: Enable Function Call Graphs in Doxygen

#### 1. **Install Graphviz**
Doxygen uses Graphviz to generate diagrams. On most Linux distros:
```bash
sudo apt install graphviz
```

---

#### 2. **Edit Your `Doxyfile` Config**

Open your `Doxyfile` and set the following options:

```ini
CALL_GRAPH           = YES
CALLER_GRAPH         = YES
HAVE_DOT             = YES
DOT_PATH             = /usr/bin/dot   # Adjust if dot is elsewhere
DOT_IMAGE_FORMAT     = svg            # Or png, depending on your preference
```

Optional (for better visuals):
```ini
DOT_GRAPH_MAX_NODES  = 50             # Increase if needed
DOT_MULTI_TARGETS    = YES
```

---

#### 3. **Document Your `main()` Function**

Make sure your `main()` function is properly documented with Doxygen-style comments:
```cpp
/**
 * @brief Entry point of the program.
 */
int main() {
    doSomething();
    return 0;
}
```

---

#### 4. **Run Doxygen and View the Graph**

After running:
```bash
doxygen Doxyfile
```

Navigate to `docs/html` and open `index.html`. Find your `main()` function page—there should be a **call graph** showing arrows to the functions it invokes.

---

### 🧩 Bonus: Visualize Class Relationships Too
If you're working with classes, also enable:
```ini
CLASS_DIAGRAMS       = YES
COLLABORATION_GRAPH  = YES
```
