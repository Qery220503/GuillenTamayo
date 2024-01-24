<template>
  <div class="email-editor">
    <editor-menu-bar
      v-slot="{ commands, isActive, getMarkAttrs }"
      :editor="editor"
    >
      <div class="pa-1" style="font-size: 1px">
        <v-btn
          icon
          tile
          :class="{ 'is-active': isActive.bold() }"
          @click="commands.bold"
        >
          <v-icon>mdi-format-bold</v-icon>
        </v-btn>

        <v-btn
          icon
          tile
          :class="{ 'is-active': isActive.italic() }"
          @click="commands.italic"
        >
          <v-icon>mdi-format-italic</v-icon>
        </v-btn>

        <v-btn
          icon
          tile
          :class="{ 'is-active': isActive.strike() }"
          @click="commands.strike"
        >
          <v-icon>mdi-format-strikethrough</v-icon>
        </v-btn>

        <v-btn
          icon
          tile
          :class="{ 'is-active': isActive.underline() }"
          @click="commands.underline"
        >
          <v-icon>mdi-format-underline</v-icon>
        </v-btn>

        <v-btn
          icon
          tile
          :class="{ 'is-active': isActive.paragraph() }"
          @click="commands.paragraph"
        >
          <v-icon>mdi-format-paragraph</v-icon>
        </v-btn>

        <v-btn
          icon
          tile
          :class="{ 'is-active': isActive.heading({ level: 1 }) }"
          @click="commands.heading({ level: 1 })"
        >
          H1
        </v-btn>

        <v-btn
          icon
          tile
          :class="{ 'is-active': isActive.heading({ level: 2 }) }"
          @click="commands.heading({ level: 2 })"
        >
          H2
        </v-btn>

        <v-btn
          icon
          tile
          :class="{ 'is-active': isActive.heading({ level: 3 }) }"
          @click="commands.heading({ level: 3 })"
        >
          H3
        </v-btn>

        <v-btn
          icon
          tile
          :class="{ 'is-active': isActive.bullet_list() }"
          @click="commands.bullet_list"
        >
          <v-icon>mdi-format-list-bulleted</v-icon>
        </v-btn>

        <v-btn
          icon
          tile
          :class="{ 'is-active': isActive.ordered_list() }"
          @click="commands.ordered_list"
        >
          <v-icon>mdi-format-list-numbered</v-icon>
        </v-btn>

        <v-btn
          icon
          tile
          :class="{ 'is-active': isActive.blockquote() }"
          @click="commands.blockquote"
        >
          <v-icon>mdi-format-quote-close</v-icon>
        </v-btn>

        <v-btn
          icon
          tile
          :class="{ 'is-active': isActive.code_block() }"
          @click="commands.code_block"
        >
          <v-icon>mdi-code-tags</v-icon>
        </v-btn>

        <v-btn
          icon
          tile
          :class="{ 'is-active': isActive.link() }"
          @click="setLink(getMarkAttrs('link'), commands.link)"
        >
          <v-icon>mdi-link-variant</v-icon>
        </v-btn>

        <v-btn icon tile @click="commands.horizontal_rule">
          <v-icon>mdi-minus</v-icon>
        </v-btn>

        <v-btn icon tile @click="commands.undo">
          <v-icon>mdi-undo</v-icon>
        </v-btn>

        <v-btn icon tile @click="commands.redo">
          <v-icon>mdi-redo</v-icon>
        </v-btn>
      </div>
    </editor-menu-bar>

    <v-divider></v-divider>

    <editor-content class="editor__content pa-1" :editor="editor" />
  </div>
</template>

<script>
import { Editor, EditorMenuBar } from "tiptap";
import EditorContent from "./EditorContent";

import {
  Blockquote,
  CodeBlock,
  HardBreak,
  Heading,
  HorizontalRule,
  OrderedList,
  BulletList,
  ListItem,
  TodoItem,
  TodoList,
  Bold,
  Code,
  Italic,
  Link,
  Strike,
  Underline,
  History
} from "tiptap-extensions";

export default {
  name: "question-content",
  components: {
    EditorContent,
    EditorMenuBar
  },
  props: {
    content: {
      type: String,
      default: ""
    }
  },
  computed: {
    $content: {
      get() {
        return this.content;
      },
      set(value) {
        this.set_prop("content", value);
      }
    }
  },
  data() {
    return {
      showCC: false,
      showBCC: false,
      toggleFormat: [],
      editor: new Editor({
        extensions: [
          new Blockquote(),
          new BulletList(),
          new CodeBlock(),
          new HardBreak(),
          new Heading({ levels: [1, 2, 3] }),
          new HorizontalRule(),
          new ListItem(),
          new OrderedList(),
          new TodoItem(),
          new TodoList(),
          new Link({ openOnClick: false }),
          new Bold(),
          new Code(),
          new Italic(),
          new Strike(),
          new Underline(),
          new History()
        ],
        onUpdate: ({ getJSON, getHTML }) => {
          let html = getHTML();
          html = html.replace("<pre><code>img:", "<img src='");
          html = html.replace(":end</code></pre>", "'>");
          this.$content = html;
          //this.update(getHTML());
        }
      })
    };
  },
  watch: {},
  created() {
    this.model = this.content;
    //this.editor.setContent(this.content);
  },
  methods: {
    set_prop(_prop, value) {
      this.$emit("update:" + _prop, value);
    },
    update(html) {
      console.log(html);
      //this.set_prop('content',html);

      //this.$content = getHTML()
    },
    setLink(attrs, command) {
      const previousUrl = attrs.href; //this.editor.getAttributes('link').href
      const url = window.prompt("URL", previousUrl);
      console.log(previousUrl);
      // cancelled
      if (url === null) {
        return;
      }
      command({ href: url });
    },
    setLinkUrl(command, url) {
      command({ href: url });
      this.hideLinkMenu();
    }
  },
  mounted() {
    this.editor.setContent(this.content);
  },
  beforeDestroy() {
    this.editor.destroy();
  }
};
</script>

<style lang="scss">
.email-editor {
  position: relative;
  border: 1px solid;
  border-radius: 4px;

  .v-btn {
    &.is-active {
      background-color: #c1c1c1;
    }
  }

  .editor__content {
    overflow-wrap: break-word;
    word-wrap: break-word;
    word-break: break-word;
    min-height: 250px;

    * {
      caret-color: currentColor;
    }

    .ProseMirror {
      &:focus {
        outline: none;
      }
    }

    ul,
    ol {
      padding-left: 1rem;
    }

    li > p,
    li > ol,
    li > ul {
      margin: 0;
    }

    a {
      color: inherit;
    }

    blockquote {
      border-left: 3px solid rgba(0, 0, 0, 0.1);
      color: rgba(0, 0, 0, 0.8);
      padding-left: 0.8rem;
      font-style: italic;

      p {
        margin: 0;
      }
    }

    img {
      max-width: 100%;
      border-radius: 3px;
    }

    table {
      border-collapse: collapse;
      table-layout: fixed;
      width: 100%;
      margin: 0;
      overflow: hidden;

      td,
      th {
        min-width: 1em;
        border: 2px solid #fafafa;
        padding: 3px 5px;
        vertical-align: top;
        box-sizing: border-box;
        position: relative;
        > * {
          margin-bottom: 0;
        }
      }

      th {
        font-weight: bold;
        text-align: left;
      }

      .selectedCell:after {
        z-index: 2;
        position: absolute;
        content: "";
        left: 0;
        right: 0;
        top: 0;
        bottom: 0;
        background: rgba(200, 200, 255, 0.4);
        pointer-events: none;
      }

      .column-resize-handle {
        position: absolute;
        right: -2px;
        top: 0;
        bottom: 0;
        width: 4px;
        z-index: 20;
        background-color: #adf;
        pointer-events: none;
      }
    }

    .tableWrapper {
      margin: 1em 0;
      overflow-x: auto;
    }

    .resize-cursor {
      cursor: ew-resize;
      cursor: col-resize;
    }
  }
}
</style>
