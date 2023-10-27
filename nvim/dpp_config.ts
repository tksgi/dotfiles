import {
  BaseConfig,
  ContextBuilder,
  Dpp,
  Plugin,
} from "https://deno.land/x/dpp_vim@v0.0.5/types.ts";
import { Denops } from "https://deno.land/x/dpp_vim@v0.0.5/deps.ts"

type Toml = {
  hooks_file?: string;
  ftplugins?: Record<string, string>;
  plugins: Plugin[];
};

type LazyMakeStateResult = {
  plugins: Plugin[];
  stateLines: string[];
};

export class Config extends BaseConfig {
  override async config(args: {
    contextBuilder: ContextBuilder;
    denops: Denops;
    basePath: string;
    dpp: Dpp;
  }): Promise<{
    checkFiles: string[];
    plugins: Plugin[];
    stateLines: string[];
  }> {
    args.contextBuilder.setGlobal({
      extParams: {
        installer: {
          checkDiff: true,
        },
      },
      protocols: ["git"],
    });

    const [context, options] = await args.contextBuilder.get(args.denops);
    
    const tomls: Toml[] = [];
    tomls.push(await args.dpp.extAction(
      args.denops,
      context,
      options,
      "toml",
      "load",
      {
        path: '$HOME/.config/nvim/toml/plugins.toml',
      },
    ) as Toml);
    
    tomls.push(await args.dpp.extAction(
      args.denops,
      context,
      options,
      "toml",
      "load",
      {
        path: '$HOME/.config/nvim/toml/dpp.toml',
        options: {
          lazy: false,
        }
      },
    ) as Toml);
    const recordPlugins: Record<string, Plugin> = {};
    const ftplugins: Record<string, Plugin> = {};
    const hooksFiles: string[] = [];
    for (const toml of tomls) {
      for (const plugin of toml.plugins) {
        recordPlugins[plugin.name] = plugin;
      }

      if (toml.ftplugins) {
        for (const filetype of object.keys(toml.ftplugins)) {
          if (ftplugins[filetype]) {
            ftplugins[filetype] += `\n${toml.ftplugins[filetype]}`;
          } else {
            ftplugins[filetype] = toml.ftplugins[filetype]
          }
        }
      }

      if (toml.hooks_file) {
        hooksFiles.push(toml.hooks_file);
      }
    }
    
    
    // const localPlugins = await args.dpp.extAction(
    //   args.denops,
    //   context,
    //   options,
    //   "local",
    //   "local",
    //   {
    //     directory: "~/local-plugin-dir",
    //     options: {
    //       frozen: true,
    //       merged: false,
    //     },
    //   },
    // ) as Plugin[];
    // 
    // for (const plugin of localPlugins) {
    //   if (plugin.name in recordPlugins) {
    //     recordPlugins[plugin.name] = Object.assign(
    //       recordPlugins[plugin.name],
    //       plugin,
    //     );
    //   } else {
    //     recordPlugins[plugin.name] = plugin;
    //   }
    // }
    
    // const recordPlugins = [
    //   {
    //     repo: 'EdenEast/nightfox.nvim',
    //     name: 'nightfox.nvim'
    //   }
    // ] as Plugin[]

    const lazyResult = await args.dpp.extAction(
      args.denops,
      context,
      options,
      "lazy",
      "makeState",
      {
        plugins: Object.values(recordPlugins),
      },
    ) as LazyMakeStateResult;

    return {
      checkFiles: [],
      ftplugins,
      hooksFiles,
      plugins: lazyResult.plugins,
      stateLines: lazyResult.stateLines,
    };
  }
}
