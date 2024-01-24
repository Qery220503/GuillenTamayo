export class RecipeService {
  static calculateFar(recipe) {
    //Jalamos Esferas
    recipe.far.oi.esf = this.parseResult(recipe.oi.esf);
    recipe.far.od.esf = this.parseResult(recipe.od.esf);
    //Jalamos cilindros
    recipe.far.oi.cyl = this.parseResult(recipe.oi.cyl);
    recipe.far.od.cyl = this.parseResult(recipe.od.cyl);
    //Jalamos Ejes
    recipe.far.oi.eje = this.parseResult(recipe.oi.eje);
    recipe.far.od.eje = this.parseResult(recipe.od.eje);

    recipe.far.oi.eje = recipe.oi.eje ?? "";
    recipe.far.od.eje = recipe.od.eje ?? "";

    //Jalamos ALT
    recipe.far.oi.alt = this.parseResult(recipe.oi.alt);
    recipe.far.od.alt = this.parseResult(recipe.od.alt);

    //Jalamos DNP
    recipe.far.oi.dnp = Number(Number(recipe.dip) / 2);
    recipe.far.od.dnp = Number(Number(recipe.dip) / 2);

    //Jalamos Prismas
    recipe.far.oi.prismas = this.parseResult(recipe.oi.prismas);
    recipe.far.od.prismas = this.parseResult(recipe.od.prismas);
  }
  static calculateIntermediate(recipe) {
    if (!recipe.oi.add_intermedio || !recipe.od.add_intermedio) {
      console.log("Calculated");
      recipe.recipe = { ...recipe.recipe, ...this.clearRecipes() };
      return;
    } else {
      // console.log(recipe.oi.add_intermedio);
      // console.log(recipe.od.add_intermedio);
    }

    //Jalamos Esferas
    recipe.intermediate.oi.esf = this.parseResult(
      Number(recipe.oi.esf) + Number(recipe.oi.add_cerca)
    );
    recipe.intermediate.od.esf = this.parseResult(
      Number(recipe.od.add_cerca) + Number(recipe.od.add_intermedio)
    );

    if (recipe.intermediate.od.esf == NaN) recipe.intermediate.esf = "";
    if (recipe.intermediate.oi.esf == NaN) recipe.intermediate.esf = "";

    //Jalamos cilindros
    recipe.intermediate.oi.cyl = this.parseResult(recipe.oi.cyl);
    recipe.intermediate.od.cyl = this.parseResult(recipe.od.cyl);
    //Jalamos Ejes
    recipe.intermediate.oi.eje = recipe.oi.eje ?? "";
    recipe.intermediate.od.eje = recipe.od.eje ?? "";
    //Jalamos ALT
    recipe.intermediate.oi.alt = this.parseResult(recipe.oi.alt);
    recipe.intermediate.od.alt = this.parseResult(recipe.od.alt);
    //Jalamos DNP
    recipe.intermediate.oi.dnp = Number((Number(recipe.dip) - 2) / 2);
    recipe.intermediate.od.dnp = Number((Number(recipe.dip) - 2) / 2);

    //Jalamos Prismas
    recipe.intermediate.oi.prismas = this.parseResult(recipe.oi.prismas);
    recipe.intermediate.od.prismas = this.parseResult(recipe.od.prismas);
  }
  static calculateNear(recipe) {
    //Sumamos esferas
    if (!recipe.oi.add_cerca || !recipe.od.add_cerca) {
      recipe.recipe = { ...recipe.recipe, ...this.clearRecipes() };
      return;
    } else {
      // console.log("Not empty", recipe.oi.add_cerca);
    }

    recipe.near.oi.esf = this.parseResult(
      Number(recipe.oi.esf) + Number(recipe.oi.add_cerca)
    );
    recipe.near.od.esf = this.parseResult(
      Number(recipe.od.esf) + Number(recipe.od.add_cerca)
    );

    if (recipe.near.od.esf == NaN) recipe.near.esf = "";
    if (recipe.near.oi.esf == NaN) recipe.near.esf = "";

    //Jalamos cilindros
    recipe.near.oi.cyl = this.parseResult(recipe.oi.cyl);
    recipe.near.od.cyl = this.parseResult(recipe.od.cyl);

    //Jalamos Ejes
    recipe.near.oi.eje = recipe.oi.eje ?? "";
    recipe.near.od.eje = recipe.od.eje ?? "";

    //Jalamos ALT
    recipe.near.oi.alt = this.parseResult(recipe.oi.alt);
    recipe.near.od.alt = this.parseResult(recipe.od.alt);

    //Jalamos DNP
    recipe.near.oi.dnp = Number((Number(recipe.dip) - 2) / 2);
    recipe.near.od.dnp = Number((Number(recipe.dip) - 2) / 2);

    //Jalamos Prismas
    recipe.near.oi.prismas = this.parseResult(recipe.oi.prismas);
    recipe.near.od.prismas = this.parseResult(recipe.od.prismas);
  }
  static calculateBifocal(recipe) {
    if (!recipe.oi.add_cerca || !recipe.od.add_cerca) {
      recipe.recipe = { ...recipe.recipe, ...this.clearRecipes() };
      return;
    } else {
      // console.log("Not empty", recipe.oi.add_cerca);
    }

    //Sumamos esferas
    recipe.bifocal.oi.esf = this.parseResult(recipe.oi.esf);
    recipe.bifocal.od.esf = this.parseResult(recipe.od.esf);
    if (recipe.bifocal.od.esf == NaN) recipe.bifocal.esf = "";
    if (recipe.bifocal.oi.esf == NaN) recipe.bifocal.esf = "";

    //Jalamos cilindros
    recipe.bifocal.oi.cyl = this.parseResult(recipe.oi.cyl);
    recipe.bifocal.od.cyl = this.parseResult(recipe.od.cyl);

    //Jalamos Ejes
    recipe.bifocal.oi.eje = recipe.oi.eje ?? "";
    recipe.bifocal.od.eje = recipe.od.eje ?? "";

    //Jalamos ALT
    recipe.bifocal.oi.alt = this.parseResult(recipe.oi.alt);
    recipe.bifocal.od.alt = this.parseResult(recipe.od.alt);

    //Jalamos DNP
    recipe.bifocal.oi.dnp = Number(Number(recipe.dip) / 2);
    recipe.bifocal.od.dnp = Number(Number(recipe.dip) / 2);

    recipe.bifocal.oi.add = this.parseResult(recipe.oi.add_cerca);
    recipe.bifocal.od.add = this.parseResult(recipe.od.add_cerca);

    recipe.bifocal.panoramic_angle = recipe.panoramic_angle;
    recipe.bifocal.pantoscopic_angle = recipe.pantoscopic_angle;
    recipe.bifocal.vertex_distance = recipe.vertex_distance;

    //Jalamos Prismas
    recipe.bifocal.oi.prismas = this.parseResult(recipe.oi.prismas);
    recipe.bifocal.od.prismas = this.parseResult(recipe.od.prismas);
  }
  static calculateMultifocal(recipe) {
    if (!recipe.oi.add_cerca || !recipe.od.add_cerca) {
      recipe.recipe = { ...recipe.recipe, ...this.clearRecipes() };
      return;
    } else {
      // console.log("Not empty", recipe.oi.add_cerca);
    }

    //Sumamos esferas
    recipe.multifocal.oi.esf = this.parseResult(recipe.oi.esf);
    recipe.multifocal.od.esf = this.parseResult(recipe.od.esf);
    if (recipe.multifocal.od.esf == NaN) recipe.multifocal.esf = "";
    if (recipe.multifocal.oi.esf == NaN) recipe.multifocal.esf = "";
    //Jalamos cilindros
    recipe.multifocal.oi.cyl = this.parseResult(recipe.oi.cyl);
    recipe.multifocal.od.cyl = this.parseResult(recipe.od.cyl);

    //Jalamos Ejes
    recipe.multifocal.oi.eje = recipe.oi.eje ?? "";
    recipe.multifocal.od.eje = recipe.od.eje ?? "";

    //Jalamos ALT
    recipe.multifocal.oi.alt = this.parseResult(recipe.oi.alt);
    recipe.multifocal.od.alt = this.parseResult(recipe.od.alt);

    //Jalamos DNP
    recipe.multifocal.oi.dnp = Number(Number(recipe.dip) / 2);
    recipe.multifocal.od.dnp = Number(Number(recipe.dip) / 2);

    //Jalamos adicion
    recipe.multifocal.oi.add = this.parseResult(recipe.oi.add_cerca);
    recipe.multifocal.od.add = this.parseResult(recipe.od.add_cerca);

    //Angulos
    recipe.multifocal.panoramic_angle = recipe.panoramic_angle;
    recipe.multifocal.pantoscopic_angle = recipe.pantoscopic_angle;
    recipe.multifocal.vertex_distance = recipe.vertex_distance;

    //Jalamos Prismas
    recipe.multifocal.oi.prismas = this.parseResult(recipe.oi.prismas);
    recipe.multifocal.od.prismas = this.parseResult(recipe.od.prismas);

    // console.log(recipe.oi.prismas);
    // console.log(recipe.od.prismas);
  }
  static parseResult(val) {
    const value = val ?? "";
    if (value === "") return value;
    const data = Number(value).toFixed(2);
    if (data == 0) return "";
    const withSymbol = data >= 0 ? `+${data}` : `${data}`;
    return withSymbol;
  }
  static clearAll() {
    return {
      dip: null,
      panoramic_angle: null,
      pantoscopic_angle: null,
      vertex_distance: null,
      od: {
        esf: null,
        cyl: null,
        add_cerca: null,
        add_intermedio: null,
        alt: null,
        prismas: null,
        avcc: null,
        eje: null,
      },
      oi: {
        esf: null,
        cyl: null,
        add_cerca: null,
        add_intermedio: null,
        alt: null,
        prismas: null,
        avcc: null,
        eje: null,
      },
      selection: "far",
      /* Specific recipes */
      near: {
        oi: {
          esf: null,
          cyl: null,
          dnp: null,
          alt: null,
          prismas: null,
          //avcc: null,
          eje: null,
        },
        od: {
          esf: null,
          cyl: null,
          dnp: null,
          alt: null,
          prismas: null,
          //avcc: null,
          eje: null,
        },
      },
      intermediate: {
        oi: {
          esf: null,
          cyl: null,
          dnp: null,
          alt: null,
          prismas: null,
          //avcc: null,
          eje: null,
        },
        od: {
          esf: null,
          cyl: null,
          dnp: null,
          alt: null,
          prismas: null,
          //avcc: null,
          eje: null,
        },
      },
      far: {
        oi: {
          esf: null,
          cyl: null,
          dnp: null,
          alt: null,
          prismas: null,
          //avcc: null,
          eje: null,
        },
        od: {
          esf: null,
          cyl: null,
          dnp: null,
          alt: null,
          prismas: null,
          //avcc: null,
          eje: null,
        },
      },
      multifocal: {
        od: {
          esf: null,
          cyl: null,
          eje: null,
          add: null,
          dnp: null,
          alt: null,
          prismas: null,
          //avcc: null,
        },
        oi: {
          esf: null,
          cyl: null,
          eje: null,
          add: null,
          dnp: null,
          alt: null,
          prismas: null,
          //avcc: null,
        },
        panoramic_angle: null,
        pantoscopic_angle: null,
        vertex_distance: null,
      },
      bifocal: {
        od: {
          esf: null,
          cyl: null,
          eje: null,
          add: null,
          dnp: null,
          alt: null,
          prismas: null,
          //avcc: null,
        },
        oi: {
          esf: null,
          cyl: null,
          eje: null,
          add: null,
          dnp: null,
          alt: null,
          prismas: null,
          //avcc: null,
        },
        panoramic_angle: null,
        pantoscopic_angle: null,
        vertex_distance: null,
      },
      contact: {
        od: {
          esf: null,
          cyl: null,
          eje: null,
          k1: null,
          k2: null,
          cb: null,
          diametro: null,
          dhiv: null,
          sag: null,
        },
        oi: {
          esf: null,
          cyl: null,
          eje: null,
          k1: null,
          k2: null,
          cb: null,
          diametro: null,
          dhiv: null,
          sag: null,
        },
        material: null,
        color: null,
        geometry: null,
        replacement: null,
      },
    };
  }

  static clearRecipes() {
    return {
      near: {
        oi: {
          esf: null,
          cyl: null,
          dnp: null,
          alt: null,
          prismas: null,
          //avcc: null,
          eje: null,
        },
        od: {
          esf: null,
          cyl: null,
          dnp: null,
          alt: null,
          prismas: null,
          //avcc: null,
          eje: null,
        },
      },
      intermediate: {
        oi: {
          esf: null,
          cyl: null,
          dnp: null,
          alt: null,
          prismas: null,
          //avcc: null,
          eje: null,
        },
        od: {
          esf: null,
          cyl: null,
          dnp: null,
          alt: null,
          prismas: null,
          //avcc: null,
          eje: null,
        },
      },
      far: {
        oi: {
          esf: null,
          cyl: null,
          dnp: null,
          alt: null,
          prismas: null,
          //avcc: null,
          eje: null,
        },
        od: {
          esf: null,
          cyl: null,
          dnp: null,
          alt: null,
          prismas: null,
          //avcc: null,
          eje: null,
        },
      },
      multifocal: {
        od: {
          esf: null,
          cyl: null,
          eje: null,
          add: null,
          dnp: null,
          alt: null,
          prismas: null,
          //avcc: null,
        },
        oi: {
          esf: null,
          cyl: null,
          eje: null,
          add: null,
          dnp: null,
          alt: null,
          prismas: null,
          //avcc: null,
        },
        panoramic_angle: null,
        pantoscopic_angle: null,
        vertex_distance: null,
      },
      bifocal: {
        od: {
          esf: null,
          cyl: null,
          eje: null,
          add: null,
          dnp: null,
          alt: null,
          prismas: null,
          //avcc: null,
        },
        oi: {
          esf: null,
          cyl: null,
          eje: null,
          add: null,
          dnp: null,
          alt: null,
          prismas: null,
          //avcc: null,
        },
        panoramic_angle: null,
        pantoscopic_angle: null,
        vertex_distance: null,
      },
      contact: {
        od: {
          esf: null,
          cyl: null,
          eje: null,
          k1: null,
          k2: null,
          cb: null,
          diametro: null,
          dhiv: null,
          sag: null,
        },
        oi: {
          esf: null,
          cyl: null,
          eje: null,
          k1: null,
          k2: null,
          cb: null,
          diametro: null,
          dhiv: null,
          sag: null,
        },
        material: null,
        color: null,
        geometry: null,
        replacement: null,
      },
    };
  }
}
