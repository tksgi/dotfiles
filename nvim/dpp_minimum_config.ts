import {
  BaseConfig,
  ContextBuilder,
  Dpp,
  Plugin,
} from "https://deno.land/x/dpp_vim@v0.0.5/types.ts";
import { Denops } from "https://deno.land/x/dpp_vim@v0.0.5/deps.ts"

export class Config extends BaseConfig {
  override async config(args: {
    contextBuilder: ContextBuilder;
  }): Promise<{
    plugins: Plugin[];
  }> {
    args.contextBuilder.setGlobal({
      protocols: ["git"],
    });

    return {
      plugins: [{
        repo: 'mfussenegger/nvim-dap',
        name: 'nvim-dap',
      },
      {
        repo: 'mfussenegger/nvim-lint',
        name: 'nvim-lint',
      }],
    };
  }
}
